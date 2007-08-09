module MagicMultiConnection::Connected
  def self.included(base)
    base.instance_eval do
      alias :pre_connected_const_missing :const_missing
  
      def const_missing(const_id)
        # return pre_connected_const_missing(const_id) rescue nil
        target_class = "#{self.parent_module}::#{const_id}".constantize rescue nil
        raise NameError.new("uninitialized constant \{const_id}") unless target_class
        
        # The code below is used to solve an issue with the acts_as_versioned
        # plugin.  Because the acts_as_versioned plugin creates a 'Version' model
        # in the namespace of the class itself, the mmc method const_missing() will
        # never get called.  To get around this issue I have modified the acts_as_versioned
        # plugin so that it uses the inherited() method and forces a new ActiveRecord object
        # to be created.  That inheritance method relies on mmc_owner function created below.
        mmc_owner = self
        klass = create_class const_id, target_class do
          @@mmc_owner = mmc_owner
          def self.mmc_owner
            @@mmc_owner
          end
        end        
        klass.establish_connection self.connection_spec
        klass
      end

      def create_class(class_name, superclass = Object, &block)
        klass = Class.new superclass, &block
        result = self.const_set(class_name, klass)
        
        # Cycle through all reflections, and redefine those reflections
        # for all relationships where the ActiveRecord Object is in the
        # same namespace.
        parent_mod = self.parent_module
        superclass.reflections.each do |reflection_name, reflection|
          if reflection.class_name.to_s.include?(parent_mod.to_s)          
            # redefine the reflection
            new_class_name = reflection.class_name.sub(parent_mod.to_s, "::#{self.name}")
            new_options = reflection.options.dup
            new_options[:class_name] = new_class_name
            case reflection.macro
            when :has_one, :has_many, :belongs_to
              new_options[:foreign_key] ||= reflection.primary_key_name
            when :has_and_belongs_to_many
              
            end
            
            klass.send reflection.macro, reflection_name, new_options
          end         
        end
        result      
      end
    end
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def establish_connection_on(klass)
      klass.establish_connection self.connection_spec
    end
  end
end


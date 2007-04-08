module MagicMultiConnection::Connected
  def self.included(base)
    puts "Including MagicMultiConnection::Connected on #{base}"
    base.instance_eval <<-EOS
      alias :pre_connected_const_missing :const_missing
  
      def const_missing(const_id)
        return pre_connected_const_missing(const_id) rescue nil
        target_class = "::\#{const_id}".constantize rescue nil
        raise NameError.new("uninitialized constant \#{const_id}") unless target_class
        klass = create_class const_id, target_class
        klass.establish_connection self.connection_spec
        klass
      end

      def create_class(class_name, superclass = Object, &block)
        klass = Class.new superclass, &block
        self.const_set class_name, klass
      end
    EOS
  end
  
end


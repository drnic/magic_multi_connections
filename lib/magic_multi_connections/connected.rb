module MagicMultiConnection::Connected
  def self.included(base)
    puts "Including MagicMultiConnection::Connected on #{base}"
    base.instance_eval <<-EOS
      alias :pre_connected_const_missing :const_missing
  
      def const_missing(const_id)
        return pre_connected_const_missing(const_id) rescue nil
        p Module.constants.sort
        p self.constants.sort
        target_class = "::\#{const_id}".constantize rescue nil
        puts "Found target_class \#{target_class.to_s} < \#{target_class.superclass.to_s}"
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


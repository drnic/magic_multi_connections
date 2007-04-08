class Module
  attr_accessor :connection_spec
  
  def establish_connection(connection_spec)
    include MagicMultiConnection::Connected
    instance_variable_set '@connection_spec', connection_spec
    update_active_records
  end
  
  def parent_module
    parent = self.name.split('::')[0..-2].join('::')
    parent = 'Object' if parent.blank?
    parent.constantize
  end
  
  private 
  def update_active_records
    self.constants.each do |c_str|
      c = "#{self.name}::#{c_str}".constantize
      next unless c.is_a? Class
      next unless c.new.is_a? ActiveRecord::Base
      c.establish_connection connection_spec
    end
  end
end

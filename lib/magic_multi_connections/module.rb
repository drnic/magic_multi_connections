class Module
  attr_accessor :connection_spec
  
  def establish_connection(connection_spec)
    include MagicMultiConnection::Connected
    instance_variable_set '@connection_spec', connection_spec
  end
end


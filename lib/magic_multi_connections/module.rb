class Module
  def establish_connection(connection_spec)
    include MagicMultiConnection::Connected
    p methods.sort
    # create_class 'Person', ActiveRecord::Base
  end
end


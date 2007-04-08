print "Using native Postgresql\n"
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

db1 = 'magic_multi_connections_unittest'

connection_options = {
  :adapter  => "postgresql",
  :encoding => "utf8",
  :database => db1
}

ActiveRecord::Base.configurations = { db1 => connection_options }
ActiveRecord::Base.establish_connection(connection_options)

print "Using native Postgresql\n"
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

db = 'magic_multi_connections_unittest'

db_connection_options = {
  :adapter  => "postgresql",
  :encoding => "utf8",
  :database => db
}

db_extra = 'magic_multi_connections_extra_unittest'

db_extra_connection_options = {
  :adapter  => "postgresql",
  :encoding => "utf8",
  :database => db_extra
}


ActiveRecord::Base.configurations = { db => db_connection_options, db_extra => db_extra_connection_options }
ActiveRecord::Base.establish_connection(db)

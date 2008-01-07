class Person < ActiveRecord::Base
  has_many :addresses
  has_many :habits, :mirror_db_connection => true
end
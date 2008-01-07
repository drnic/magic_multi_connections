class Habit < ActiveRecord::Base
  belongs_to :person, :mirror_db_connection => true
end

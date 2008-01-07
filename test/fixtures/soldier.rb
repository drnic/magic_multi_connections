module Army
  
  class Soldier < ActiveRecord::Base
    has_many :assignments
    has_many :paychecks
  end
end

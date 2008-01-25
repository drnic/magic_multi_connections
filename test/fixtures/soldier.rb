module Army
  
  class Soldier < ActiveRecord::Base
    has_many :assignments
    has_many :paychecks
    has_many :citations, :class_name => "Justice::Citation"
  end
end

module Justice
  
  class Citation < ActiveRecord::Base
    belongs_to :soldier, :class_name => "Army::Soldier"
  end
end
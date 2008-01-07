module Army
  
  class Assignment < ActiveRecord::Base
    belongs_to :soldier
  end
  
end

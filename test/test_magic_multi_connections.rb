require File.dirname(__FILE__) + '/test_helper.rb'

class TestMagicMultiConnection < Test::Unit::TestCase

  def setup
    create_fixtures :people
  end
  
  def test_classes
    assert_nothing_raised(Exception) { Person }
    assert(normal_person = Person.find(1), "Cannot get Person instances")
    assert_nothing_raised(Exception) { ContactRepository::Person }
  end
end

require File.dirname(__FILE__) + '/test_helper.rb'

class TestMagicMultiConnection < Test::Unit::TestCase

  def setup
    create_fixtures :people
  end
  
  def test_classes
    assert_nothing_raised(Exception) { Person }
    assert_equal('ActiveRecord::Base', Person.active_connection_name)
    assert(normal_person = Person.find(1), "Cannot get Person instances")
    assert_nothing_raised(Exception) { ContactRepository::Person }
    assert_equal(Person, ContactRepository::Person.superclass)
    assert_equal('ContactRepository::Person', ContactRepository::Person.name)
    assert_equal('ContactRepository::Person', ContactRepository::Person.active_connection_name)
    assert_equal(0, ContactRepository::Person.count)
  end
end

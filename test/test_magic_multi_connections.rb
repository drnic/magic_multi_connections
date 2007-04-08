require File.dirname(__FILE__) + '/test_helper.rb'

module NormalModule; end

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
  
  def test_normal_modules_shouldnt_do_anything
    assert_raise(NameError) { NormalModule::Person }
    
  end
end

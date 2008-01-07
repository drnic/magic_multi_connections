require File.dirname(__FILE__) + '/test_helper.rb'

class TestMmcAssociations < Test::Unit::TestCase

  def setup

  end
  
  def test_namespace_associations
    assert_nothing_raised(Exception) do
      Army::Soldier
      Army::Assignment
      Paycheck
    end
    
    assert_equal Army::Assignment, Army::Soldier.reflections[:assignments].klass
    assert_equal Paycheck, Army::Soldier.reflections[:paychecks].klass
    
    assert_equal true, Army::Classified.namespace_reflections_mirror_db
    
    assert_nothing_raised(Exception) { Army::Classified::Soldier }
    assert_equal Army::Classified::Assignment, Army::Classified::Soldier.reflections[:assignments].klass
    assert_equal Paycheck, Army::Classified::Soldier.reflections[:paychecks].klass
  end
  
  def test_explicit_associations
    assert_nothing_raised(Exception) do
      Person
      Habit
      Address
    end
    
    assert_equal Address, Person.reflections[:addresses].klass
    assert_equal :default, Person.reflections[:addresses].mirror_db_connection
    assert_equal Habit, Person.reflections[:habits].klass
    assert_equal true, Person.reflections[:habits].mirror_db_connection
    
    assert_equal false, ContactRepository.namespace_reflections_mirror_db
    
    assert_nothing_raised(Exception) { ContactRepository::Person }
    assert_equal Address, ContactRepository::Person.reflections[:addresses].klass
    assert_equal ContactRepository::Habit, ContactRepository::Person.reflections[:habits].klass
  end
end

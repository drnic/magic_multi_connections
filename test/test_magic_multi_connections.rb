require File.dirname(__FILE__) + '/test_helper.rb'

class TestMagicMultiConnection < Test::Unit::TestCase

  def setup
  end
  
  def test_classes
    assert_nothing_raised(Exception) { Person }
    assert_nothing_raised(Exception) { ContactRepository::Person }
  end
end

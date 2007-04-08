require File.dirname(__FILE__) + '/test_helper.rb'

module A
  module B
    module C
      class Z
      end
    end
  end
end

class TestParentModule < Test::Unit::TestCase

  def test_method
    assert_equal(A::B::C, A::B::C::Z.parent_module)
    assert_equal(Object, A.parent_module)
  end
end

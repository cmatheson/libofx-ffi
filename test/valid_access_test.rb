require 'ofx/ffi/valid_access'
require 'test/unit'

class ValidAccessTest < Test::Unit::TestCase
  def test_valid_access
    h = {
      :foo => 'blah',
      :foo_valid => 1,
      :bar => 'glah',
      :bar_valid => 0,
      :baz => 'zoing'
    }
    class << h
      include OFX::FFI::ValidAccess
    end

    assert_equal 'blah', h.foo
    assert_nil h.bar
    assert_nil h.baz
  end
end

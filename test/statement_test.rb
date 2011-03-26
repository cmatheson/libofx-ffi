require 'ofx/statement'
require 'test/unit'

class StatementTest < Test::Unit::TestCase
  def setup
    @s = OFX::Statement.new
    @s[:foo] = 1
    @s[:bar] = 2
  end

  def test_account_setting_and_getting
    assert_equal 1, @s[:foo]
    assert_equal 2, @s[:bar]
    assert_nil @s[:baz]
  end

  def test_each
    expected = ["foo", 1, "bar", 2]

    @s.each do |k,v|
      assert_equal expected.shift, k
      assert_equal expected.shift, v
    end

    assert_equal [], expected
  end
end

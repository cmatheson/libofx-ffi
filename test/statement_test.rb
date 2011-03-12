require 'ofx/statement'
require 'test/unit'

class StatementTest < Test::Unit::TestCase
  def test_account_setting_and_getting
    s = OFX::Statement.new
    s[:foo] = 1
    s[:bar] = 2
    assert_equal 1, s[:foo]
    assert_equal 2, s[:bar]
    assert_nil s[:baz]
  end
end

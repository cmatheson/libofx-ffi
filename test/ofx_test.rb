require 'ofx'
require 'test/unit'

class OfxTest < Test::Unit::TestCase
  def setup
    @statement = OFX.parse 'test/test.ofx'
  end

  def test_ofx_file_must_exist
    assert_raise Errno::ENOENT do
      OFX.parse 'test/blah.ofx'
    end
  end

  def test_account_must_exist
    refute_nil @statement["987654321"]
  end

  def test_transactions_are_correct
    transactions = @statement["987654321"].transactions

    expected = [
      { :type => :debit, :amount => -100, :number => "0000009",
        :name => /AUTOMATIC WITHDRAWAL/, :memo => /AUTOMATIC WITHDRAWAL/,
        :date => Time.new(2011, 1, 3, 11, 0, 0, "-07:00") },
      { :type => :check, :amount => -146.64, :number => "0000008",
        :name => "CHECK # 515",
        :date => Time.new(2011, 1, 10, 11, 0, 0, "-07:00") },
      { :type => :credit, :amount => 1600.01, :number => "0000007",
        :name => /AUTOMATIC DEPOSIT/, :memo => /AUTOMATIC DEPOSIT/,
        :date => Time.new(2011, 1, 13, 11, 0, 0, "-07:00") }
    ]

    transactions.each do |transaction|
      expected.shift.each do |attribute, expected_value|
        got = transaction.send(attribute)
        assert expected_value === got, "expected #{expected_value}, but got #{got}"
      end
    end
  end
end

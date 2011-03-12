require 'time'

module OFX
  class Transaction
    attr_reader :number, :date, :type, :name, :memo, :amount

    def initialize(ffi_transaction)
      @number = ffi_transaction.fi_id.to_s
      @date = Time.at ffi_transaction.date_posted
      @memo = ffi_transaction.memo.to_s
      @name = ffi_transaction.name.to_s
      @type = ffi_transaction.transaction_type
      @amount = ffi_transaction.amount
      @transactions = []
    end
  end
end

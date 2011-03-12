module OFX
  class Account
    attr_reader   :number, :type
    attr_accessor :transactions

    def initialize(ffi_account)
      @number = ffi_account.account_number
      @type   = ffi_account.account_type

      @transactions = []
    end
  end
end

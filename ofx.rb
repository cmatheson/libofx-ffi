require 'ffi'

class OFX
  AccountCallback = Proc.new do |acct, junk|
    puts "Account! #{acct[:account_name]}"
  end

  def initialize
    @context = FFI.libofx_get_new_context
    FFI.ofx_set_account_cb @context, AccountCallback
    FFI.ofx_proc_file @context, "secret.ofx", 0
    FFI.libofx_free_context(@context)
  end

  module FFI
    extend ::FFI::Library
    ffi_lib 'ofx'

    AccountType = enum :checking, :savings, :money_market, :credit_line,
                       :cma, :credit_card, :investment

    # LibofxContextPtr is void*
    attach_function :libofx_get_new_context, [], :pointer
    attach_function :libofx_free_context, [:pointer], :int

    attach_function :ofx_proc_file, [:pointer, :pointer, :int], :int

    class AccountData < ::FFI::Struct
      layout :account_id, [:char, 57],
        :account_name, [:char, 255],
        :account_id_valid, :int,
        :account_type, AccountType,
        :account_type_valid, :int,
        :currency, [:char, 4],
        :currency_valid, :int,
        :account_number, [:char, 23],
        :bank_id, [:char, 10],
        :bank_id_valid, :int,
        :broker_id, [:char, 23],
        :broker_id_valid, :int,
        :branch_id, [:char, 23],
        :branch_id_valid, :int
    end
    callback :account_callback, [AccountData.by_value, :pointer], :int
    attach_function :ofx_set_account_cb, [:pointer, :account_callback], :void
  end
end

OFX.new

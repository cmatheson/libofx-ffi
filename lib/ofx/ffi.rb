module OFX
  module FFI
    extend ::FFI::Library
    ffi_lib 'ofx'

    # LibofxContextPtr is void*
    attach_function :libofx_get_new_context, [], :pointer
    attach_function :libofx_free_context, [:pointer], :int

    attach_function :ofx_proc_file, [:pointer, :pointer, :int], :int

    AccountType = enum :checking, :savings, :money_market, :credit_line,
                       :cma, :credit_card, :investment
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


    TransactionType = enum :credit, :debit, :interest, :dividend, :fee,
                           :service_change, :deposit, :atm, :point_of_sale,
                           :transfer, :check, :payment, :cash_withdrawal,
                           :direct_deposit, :direct_debit, :repeat_payment,
                           :other
    class TransactionData < ::FFI::Struct
      layout :account_id, [:char, 57],
        :account_ptr, :pointer,
        :account_id_valid, :int,
        :transaction_type, TransactionType,
        :transaction_type_valid, :int,
        :investment_transaction_type, :int, # this is really an enum but i don't care about it right now
        :investment_transaction_type_valid, :int,
        :units, :double,
        :units_valid, :int,
        :unit_price, :double,
        :units_price_valid, :int,
        :amount, :double,
        :amount_valid, :int,
        :fi_id, [:char, 256],
        :fi_id_valid, :int,
        :unique_id, [:char, 33],
        :unique_id_valid, :int,
        :unique_id_type, [:char, 11],
        :unique_id_type_valid, :int,
        :security_data, :pointer,
        :security_data_valid, :int,
        :date_posted, :int, # really a time_t
        :date_posted_valid, :int,
        :date_initiated, :int, #time_t
        :date_initiated_valid, :int,
        :date_funds_available, :int, # time_t
        :date_funds_available_valid, :int,
        :fi_id_corrected, [:char, 256],
        :fi_id_corrected_valid, :int,
        :fi_id_corrected_action, :int, #really an enum
        :fi_id_corrected_action_valid, :int,
        :server_transaction_id, [:char, 37],
        :server_transaction_id_valid, :int,
        :check_number, [:char, 13],
        :check_number_valid, :int,
        :reference_number, [:char, 33],
        :reference_number_valid, :int,
        :standard_industrial_code, :long,
        :standard_industrial_code_valid, :int,
        :payee_id, [:char, 37],
        :payee_id_valid, :int,
        :name, [:char, 33],
        :name_valid, :int,
        :memo, [:char, 391],
        :memo_valid, :int,
        :commission, :double,
        :commission_valid, :int,
        :fees, :double,
        :fees_valid, :int
    end
    callback :transaction_callback, [TransactionData.by_value, :pointer], :int
    attach_function :ofx_set_transaction_cb, [:pointer, :transaction_callback], :void
  end
end

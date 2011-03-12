require 'ffi'

require 'ofx/ffi'

require 'ofx/statement'
require 'ofx/account'
require 'ofx/transaction'

module OFX
  AccountCallback = Proc.new do |acct_data, junk|
    account = Account.new(acct_data)
    @statement[account.number] = account
    0
  end

  TransactionCallback = Proc.new do |t, junk|
    acct_data = FFI::AccountData.new t[:account_ptr]
    acct_num  = acct_data.account_number
    @statement[acct_num].transactions << Transaction.new(t)
    0
  end

  def self.parse(file_name)
    raise Errno::ENOENT unless File.exist? file_name

    @statement = OFX::Statement.new

    context = FFI.libofx_get_new_context
    FFI.ofx_set_account_cb context, AccountCallback
    FFI.ofx_set_transaction_cb context, TransactionCallback
    FFI.ofx_proc_file context, file_name, 0
    FFI.libofx_free_context context

    @statement
  end
end

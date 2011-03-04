require 'ofx/ffi'

module OFX
  AccountCallback = Proc.new do |acct, junk|
    puts "Account! #{acct[:account_name]}"
  end

  TransactionCallback = Proc.new do |t, junk|
    puts "  Transaction! #{t[:amount]} #{t[:transaction_type]}"
  end

  def self.parse(file_name)
    @context = FFI.libofx_get_new_context
    FFI.ofx_set_account_cb @context, AccountCallback
    FFI.ofx_set_transaction_cb @context, TransactionCallback
    FFI.ofx_proc_file @context, file_name, 0
    FFI.libofx_free_context(@context)
  end
end

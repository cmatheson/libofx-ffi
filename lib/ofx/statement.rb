module OFX
  class Statement
    def initialize
      @accounts = {}
    end

    def [](key)
      # have to call to_s because the original key from ffi is a CharArray
      # (equality doesn't do what i want)
      @accounts[key.to_s]
    end

    def []=(key, val)
      @accounts[key.to_s] = val
    end

    def each
      @accounts.each do |number, account|
        yield account
      end
    end
  end
end

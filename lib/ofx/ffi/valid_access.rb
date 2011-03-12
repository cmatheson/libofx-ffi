module OFX
  module FFI
    module ValidAccess
      def self.included(c)
        class_eval do
          def method_missing(attribute, *args)
            self[:"#{attribute}_valid"] == 1 ? self[attribute] : nil
          end
        end
      end
    end
  end
end

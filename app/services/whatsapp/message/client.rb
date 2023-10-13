module Whatsapp
  module Message
    class Client < ::Whatsapp::Client
      attr_reader :account_id

      def initialize(account_id)
        @account_id = account_id
      end

      def messages
        Message::Resource.new(self)
      end
    end
  end
end

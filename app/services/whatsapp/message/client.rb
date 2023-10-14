module Whatsapp
  module Message
    class Client < ::Whatsapp::Client

      def initialize(account_id)
        @account ||= Account.find(account_id)
        @whatsapp ||= @account.default_whatsapp
      end

      def messages
        Message::Resource.new(self)
      end
    end
  end
end

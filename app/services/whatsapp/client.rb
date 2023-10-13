module Whatsapp
  class Client
    BASE_URL = ENV.fetch('WHATSAPP_BASE_URL', 'https://graph.facebook.com/v18.0').freeze
    attr_accessor :account

    def initialize(account_id:)
      @account = Account.find(account_id)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.headers = {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{ENV.fetch('WHATSAPP_API_KEY', nil)}"
        }
        conn.adapter adapter
      end
    end

    def adapter
      @adapter ||= Faraday.default_adapter
    end
  end
end

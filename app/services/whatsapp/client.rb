module Whatsapp
  class Client
    BASE_URL = ENV.fetch('WHATSAPP_BASE_URL', 'https://graph.facebook.com/v18.0').freeze
    attr_accessor :account
    attr_accessor :whatsapp

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = "#{BASE_URL}/#{whatsapp.phone_number_id}"
        conn.headers = {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{whatsapp.access_token}"
        }
        conn.adapter adapter
      end
    end

    def adapter
      @adapter ||= Faraday.default_adapter
    end
  end
end

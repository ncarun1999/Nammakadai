module Whatsapp
  class Message::Resource < Whatsapp::Resource
    PATH = 'messages'.freeze

    def initialize(client)
      @client = client
    end

    def text(to:, text:)
      post_request(PATH, body: process_text_body(to, text))
    end

    private

    def process_text_body(to, text)
      { messaging_product: 'whatsapp', to: to, type: 'text', text: { preview_url: 'true', body: text } }.to_json
    end
  end
end

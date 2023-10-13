module Whatsapp
  class Message::Resource < Whatsapp::Resource
    PATH = 'messages'.freeze

    def initialize(client)
      @client = client
    end

    def create(body:)
      post_request("131754550027335/#{PATH}", body: body)
    end
  end
end

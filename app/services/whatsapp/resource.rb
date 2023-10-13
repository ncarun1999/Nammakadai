module Whatsapp
  class Resource
    attr_accessor :client

    def initialize(client)
      @client = client
    end

    def post_request(url, body:, params: {})
      @client.connection.post(url, body)
    end

    private

    def process_params(data = {})
      data
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Your request was malformed: #{format_error_message(response.body)}"
      when 401
        raise Error, "You did not supply valid authentication credentials. #{format_error_message(response.body)}"
      when 403
        raise Error, "You are not allowed to perform that action. #{format_error_message(response.body)}"
      when 404
        raise Error, "No results were found for your request. #{format_error_message(response.body)}"
      when 429
        raise Error, "Your request exceeded the API rate limit. #{format_error_message(response.body)}"
      when 500
        raise Error, "We were unable to perform the request due to server-side problems. #{format_error_message(response.body)}"
      when 503
        raise Error, "You have been rate limited for sending more than 20 requests per second. #{format_error_message(response.body)}"
      end

      response
    end

    def format_error_message(response_body)
      error_type = response_body['error_type']
      error_code = response_body['error_code']
      error_message = response_body['error_message']

      "#{error_type} (#{error_code}) - #{error_message}"
    end
  end
end

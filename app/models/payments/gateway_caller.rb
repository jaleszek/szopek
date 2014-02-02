require 'net/http'

module Payments
  class GatewayCaller
    attr_reader :input, :response

    def initialize(input)
      @input = input
    end

    def call
      uri = URI.parse(Settings.payment_endpoint_address)

      begin
        @response ||= Net::HTTP.post_form(uri, input)
      rescue StandardError
        @response = nil
      end
    end
  end
end


module Payments
  class RedirectionResolver
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def redirect_url
      response.header['Location'] if redirection_response_code?
    end

    private

    def redirection_response_code?
      response.try(:code) == '302'
    end
  end
end

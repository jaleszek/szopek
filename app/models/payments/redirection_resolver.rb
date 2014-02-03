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

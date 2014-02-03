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

    def redirect_url
      Payments::RedirectionResolver.new(response).redirect_url
    end

    def accepted?
      redirect_url.present?
    end
  end
end

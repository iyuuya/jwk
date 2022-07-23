# frozen_string_literal: true

require "faraday"
require "faraday-http-cache"

module JWK
  class Google
    JWK_URL = "https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com"

    attr_reader :client

    def initialize(http_cache_options = {})
      @client = Faraday.new do |builder|
        builder.use :http_cache, http_cache_options
        builder.request :url_encoded
        builder.response :json, parser_options: { symbolize_names: true }, content_type: "application/json"
        builder.adapter Faraday.default_adapter
      end
    end

    def retrieve
      res = @client.get(JWK_URL)
      res.body
    end
  end
end

# frozen_string_literal: true

require "faraday"
require "faraday-http-cache"

module JWK
  class Cognito
    def initialize(region, user_pool_id, http_cache_options = {})
      @url = "https://cognito-idp.#{region}.amazonaws.com/#{user_pool_id}/.well-known/jwks.json"
      @client = Faraday.new do |builder|
        builder.use :http_cache, http_cache_options
        builder.request :url_encoded
        builder.response :json, parser_options: { symbolize_names: true }, content_type: "application/json"
        builder.adapter Faraday.default_adapter
      end
    end

    def retrieve
      res = @clinet.get(@url)
      res.body
    end
  end
end

# frozen_string_literal: true

require_relative "jwk/version"

module JWK
  class Error < StandardError; end

  autoload :Google, "jwk/google"
end

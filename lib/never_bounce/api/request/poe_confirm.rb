
require "never_bounce/api/response/poe_confirm"

require_relative "base"

module NeverBounce; module API; module Request
  class POEConfirm < Base
    # @return [String]
    attr_accessor :email

    # @return [String]
    attr_accessor :transaction_id

    # @return [String]
    attr_accessor :confirmation_token

    # @return [String]
    attr_accessor :result

    # @return [Symbol]
    def self.http_method
      :get
    end

    # @return [String]
    def self.path
      "poe/confirm"
    end

    # @return [Response::POEConfirm]
    def self.response_klass
      Response::POEConfirm
    end

    # @return [Hash]
    def to_h
      {
        email: require_attr(:email),
        transaction_id: require_attr(:transaction_id),
        confirmation_token: require_attr(:confirmation_token),
        result: require_attr(:result),
        key: require_attr(:api_key),
      }
    end
  end
end; end; end

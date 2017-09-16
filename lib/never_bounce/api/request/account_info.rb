
require "never_bounce/api/response/account_info"

require_relative "base"

module NeverBounce; module API; module Request
  class AccountInfo < Base
    # @return [Symbol]
    def self.http_method
      :get
    end

    # @return [String]
    def self.path
      "account/info"
    end

    # @return [Response::AccountInfo]
    def self.response_klass
      Response::AccountInfo
    end

    def to_h
      {
        key: require_attr(:api_key),
      }
    end
  end
end; end; end

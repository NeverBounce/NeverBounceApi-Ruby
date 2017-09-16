
require "never_bounce/api/response/single_check"

require_relative "base"

module NeverBounce; module API; module Request
  class SingleCheck < Base
    # @return [String]
    attr_accessor :email

    # @return [Boolean]
    attr_accessor :address_info

    # @return [Boolean]
    attr_accessor :credits_info

    # @return [Integer]
    attr_accessor :timeout

    # @return [Symbol]
    def self.http_method
      :get
    end

    # @return [String]
    def self.path
      "single/check"
    end

    # @return [Response::SingleCheck]
    def self.response_klass
      Response::SingleCheck
    end

    # Return a ready-to-merge mode attributes hash.
    # @return [Hash]
    def mode_h
      @mode_h ||= {}.tap do |_|
        unless (v = address_info).nil?
          _[:address_info] = v
        end

        unless (v = credits_info).nil?
          _[:credits_info] = v
        end

        unless (v = timeout).nil?
          _[:timeout] = v
        end
      end
    end

    # @return [Hash]
    def to_h
      {
        email: require_attr(:email),
        key: require_attr(:api_key),
      }.merge(mode_h)
    end
  end
end; end; end

#
# Implementation notes:
#
# * `address_info` and `credits_info` have ugly names for bools, but I keep them for consistency
#   with the server protocol. We've got the docs stating their type, too.

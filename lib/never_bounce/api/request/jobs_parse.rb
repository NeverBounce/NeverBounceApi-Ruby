
require "never_bounce/api/response/jobs_parse"

require_relative "base"

module NeverBounce; module API; module Request
  class JobsParse < Base
    # @return [Integer]
    attr_accessor :job_id

    # @return [Boolean]
    attr_accessor :auto_start

    # @return [Symbol]
    def self.http_method
      :post
    end

    # @return [String]
    def self.path
      "jobs/parse"
    end

    # @return [Response::JobsParse]
    def self.response_klass
      Response::JobsParse
    end

    # Return a ready-to-merge mode attributes hash.
    # @return [Hash]
    def mode_h
      @mode_h ||= {}.tap do |_|
        unless (v = auto_start).nil?
          _[:auto_start] = v
        end
      end
    end

    # @return [Hash]
    def to_h
      {
        job_id: require_attr(:job_id),
        key: require_attr(:api_key),
      }.merge(mode_h)
    end
  end
end; end; end

#
# Implementation notes:
#
# * A convention for all classes working with mode attributes like `auto_start`.
#   * `to_h[:auto_start]` is present if value is not `nil`.
#   * Passing `request.auto_start = nil` from the outside doesn't affect `to_h` result.
#     Thus `nil` value renders the request to use server defaults.

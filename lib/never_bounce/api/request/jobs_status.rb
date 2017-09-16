
require "never_bounce/api/response/jobs_status"

require_relative "base"

module NeverBounce; module API; module Request
  class JobsStatus < Base
    # @return [Integer]
    attr_accessor :job_id

    # @return [Boolean]
    attr_accessor :auto_start

    # @return [Symbol]
    def self.http_method
      :get
    end

    # @return [String]
    def self.path
      "jobs/status"
    end

    # @return [Response::JobsStatus]
    def self.response_klass
      Response::JobsStatus
    end

    # @return [Hash]
    def to_h
      {
        job_id: require_attr(:job_id),
        key: require_attr(:api_key),
      }
    end
  end
end; end; end

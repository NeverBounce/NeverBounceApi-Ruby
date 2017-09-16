
require "never_bounce/api/response/jobs_delete"

require_relative "base"

module NeverBounce; module API; module Request
  class JobsDelete < Base
    # @return [Integer]
    attr_accessor :job_id

    # @return [Symbol]
    def self.http_method
      :post
    end

    # @return [String]
    def self.path
      "jobs/delete"
    end

    # @return [Response::Jobs::Delete]
    def self.response_klass
      Response::JobsDelete
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

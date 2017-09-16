
require "never_bounce/api/response/jobs_download"

require_relative "base"

module NeverBounce; module API; module Request
  class JobsDownload < Base
    # @return [Integer]
    attr_accessor :job_id

    # @return [Symbol]
    def self.http_method
      :get
    end

    # @return [String]
    def self.path
      "jobs/download"
    end

    # @return [Response::JobsDownload]
    def self.response_klass
      Response::JobsDownload
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

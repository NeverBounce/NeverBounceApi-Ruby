
require "never_bounce/api/response/jobs_start"

require_relative "base"

module NeverBounce; module API; module Request
  class JobsStart < Base
    # @return [Integer]
    attr_accessor :job_id

    # @return [Boolean]
    attr_accessor :run_sample

    # @return [Boolean]
    attr_accessor :allow_manual_review

    # @return [Symbol]
    def self.http_method
      :post
    end

    # @return [String]
    def self.path
      "jobs/start"
    end

    # @return [Response::JobsStart]
    def self.response_klass
      Response::JobsStart
    end

    # Return a ready-to-merge mode attributes hash.
    # @return [Hash]
    def mode_h
      @mode_h ||= {}.tap do |_|
        unless (v = run_sample).nil?
          _[:run_sample] = v
        end

        unless (v = allow_manual_review).nil?
          _[:allow_manual_review] = v
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

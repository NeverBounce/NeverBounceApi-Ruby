
require "never_bounce/api/response/jobs_results"

require_relative "base"

module NeverBounce; module API; module Request
  class JobsResults < Base
    # @return [Integer]
    attr_accessor :job_id

    # @return [Integer]
    attr_accessor :page

    # @return [Integer]
    attr_accessor :per_page

    # @return [Symbol]
    def self.http_method
      :get
    end

    # @return [String]
    def self.path
      "jobs/results"
    end

    # @return [Response::JobsResults]
    def self.response_klass
      Response::JobsResults
    end

    # @return [Hash]
    def mode_h
      @mode_h ||= {}.tap do |_|
        unless (v = per_page).nil?
          _[:items_per_page] = v
        end

        unless (v = page).nil?
          _[:page] = v
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

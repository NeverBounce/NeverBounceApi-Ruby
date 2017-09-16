
require "never_bounce/api/response/jobs_search"

require_relative "base"

module NeverBounce; module API; module Request
  class JobsSearch < Base
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
      "jobs/search"
    end

    # @return [Response::JobsSearch]
    def self.response_klass
      Response::JobsSearch
    end

    # Return a ready-to-merge mode attributes hash.
    # @return [Hash]
    def mode_h
      @mode_h ||= {}.tap do |_|
        unless (v = job_id).nil?
          _[:job_id] = v
        end

        unless (v = page).nil?
          _[:page] = v
        end

        unless (v = per_page).nil?
          _[:items_per_page] = v
        end
      end
    end

    # @return [Hash]
    def to_h
      {
        key: require_attr(:api_key),
      }.merge(mode_h)
    end
  end
end; end; end

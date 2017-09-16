
require_relative "success_message"

module NeverBounce; module API; module Response
  class JobsSearch < SuccessMessage
    require_relative "jobs_search/result"
    require_relative "jobs_search/query"

    # @!attribute query
    #   @return [Query]
    oattr :query, :writer

    # @!attribute results
    #   @return [Array<Result>]
    oattr :results, :writer

    # @!attribute total_pages
    #   @return [Integer]
    oattr :total_pages, :scalar, type: :integer

    # @!attribute total_results
    #   @return [Integer]
    oattr :total_results, :scalar, type: :integer

    def query
      @query ||= Query.new(body_hash: body_hash.fetch("query"))
    end

    def results
      @results ||= body_hash.fetch("results").map { |h| Result.new(body_hash: h) }
    end
  end
end; end; end

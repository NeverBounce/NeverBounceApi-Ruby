
require_relative "success_message"

module NeverBounce; module API; module Response
  class JobsResults < SuccessMessage
    require_relative "jobs_results/item"
    require_relative "jobs_results/query"

    # @!attribute items
    #   @return [Array<Item>]
    oattr :items, :writer

    # @!attribute query
    #   @return [Query]
    oattr :query, :writer

    # @!attribute total_pages
    #   @return [Integer]
    oattr :total_pages, :scalar, type: :integer

    # @!attribute total_results
    #   @return [Integer]
    oattr :total_results, :scalar, type: :integer

    def items
      # NOTE: I take courage to rename original response key since having class `Results::Result` is total ugliness.
      @items ||= body_hash.fetch("results").map { |h| Item.new(body_hash: h) }
    end

    def query
      @query ||= Query.new(body_hash: body_hash.fetch("query"))
    end
  end
end; end; end

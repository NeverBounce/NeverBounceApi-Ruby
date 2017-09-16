
require "never_bounce/api/response/container"

require_relative "../jobs_search"

module NeverBounce; module API; module Response; class JobsSearch
  class Query < Container
    # @!attribute items_per_page
    #   @return [Integer]
    oattr :items_per_page, :scalar, type: :integer

    # @!attribute page
    #   @return [Integer]
    oattr :page, :scalar, type: :integer
  end
end; end; end; end

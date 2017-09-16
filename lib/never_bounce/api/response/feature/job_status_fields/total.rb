
require_relative "../job_status_fields"

module NeverBounce; module API; module Response; module Feature; module JobStatusFields
  class Total < Container
    # @!attribute bad_syntax
    #   @return [Integer]
    oattr :bad_syntax, :scalar, type: :integer, allow_nil: true

    # @!attribute billable
    #   @return [Integer]
    oattr :billable, :scalar, type: :integer, allow_nil: true

    # @!attribute catchall
    #   @return [Integer]
    oattr :catchall, :scalar, type: :integer, allow_nil: true

    # @!attribute disposable
    #   @return [Integer]
    oattr :disposable, :scalar, type: :integer, allow_nil: true

    # @!attribute duplicates
    #   @return [Integer]
    oattr :duplicates, :scalar, type: :integer, allow_nil: true

    # @!attribute invalid
    #   @return [Integer]
    oattr :invalid, :scalar, type: :integer, allow_nil: true

    # @!attribute processed
    #   @return [Integer]
    oattr :processed, :scalar, type: :integer, allow_nil: true

    # @!attribute records
    #   @return [Integer]
    oattr :records, :scalar, type: :integer, allow_nil: true

    # @!attribute unknown
    #   @return [Integer]
    oattr :unknown, :scalar, type: :integer, allow_nil: true

    # @!attribute valid
    #   @return [Integer]
    oattr :valid, :scalar, type: :integer, allow_nil: true
  end
end; end; end; end; end

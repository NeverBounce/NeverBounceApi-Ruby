
require_relative "../account_info"

module NeverBounce; module API; module Response; class AccountInfo
  class JobCounts < Container
    # @!attribute completed
    #   Number of completed jobs.
    #   @return [Integer]
    oattr :completed, :scalar, type: :integer

    # @!attribute processing
    #   Number of jobs in processing.
    #   @return [Integer]
    oattr :processing, :scalar, type: :integer   #:nodoc:

    # @!attribute queued
    #   Number of queued jobs.
    #   @return [Integer]
    oattr :queued, :scalar, type: :integer

    # @!attribute under_review
    #   Number of items under review.
    #   @return [Integer]
    oattr :under_review, :scalar, type: :integer
  end
end; end; end; end

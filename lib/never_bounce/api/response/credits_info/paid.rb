
require_relative "base"

module NeverBounce; module API; module Response; module CreditsInfo
  class Paid < Base
    # @!attribute paid_credits_remaining
    #   @return [Integer]
    oattr :paid_credits_remaining, :scalar, type: :integer

    # @!attribute paid_credits_used
    #   @return [Integer]
    oattr :paid_credits_used, :scalar, type: :integer

    # Always <tt>:paid</tt>.
    # @return [Symbol]
    def subscription_type
      :paid
    end
  end
end; end; end; end

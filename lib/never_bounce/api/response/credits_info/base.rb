
require_relative "../container"

module NeverBounce; module API; module Response; module CreditsInfo
  class Base < Container
    # @!attribute free_credits_remaining
    #   @return [Integer]
    oattr :free_credits_remaining, :scalar, type: :integer

    # @!attribute free_credits_used
    #   @return [Integer]
    oattr :free_credits_used, :scalar, type: :integer

    # <tt>:monthly</tt> or <tt>:paid</tt>.
    # @return [Symbol]
    def subscription_type
      raise NotImplementedError, "Redefine `subscription_type` in final class: #{self.class}"
    end

    # <tt>true</tt> if monthly subscription.
    def monthly?
      subscription_type == :monthly
    end

    # <tt>true</tt> if paid subscription.
    def paid?
      subscription_type == :paid
    end
  end
end; end; end; end

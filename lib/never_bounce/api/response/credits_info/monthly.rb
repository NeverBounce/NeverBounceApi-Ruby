
require_relative "base"

module NeverBounce; module API; module Response; module CreditsInfo
  class Monthly < Base
    # @!attribute monthly_api_usage
    #   @return [Integer]
    oattr :monthly_api_usage, :scalar, type: :integer

    # Always <tt>:monthly</tt>.
    # @return [Symbol]
    def subscription_type
      :monthly
    end
  end
end; end; end; end

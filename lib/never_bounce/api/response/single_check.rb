
require "never_bounce/api/response/address_info"
require "never_bounce/api/response/credits_info/monthly"
require "never_bounce/api/response/credits_info/paid"

require_relative "success_message"

module NeverBounce; module API; module Response;
  class SingleCheck < SuccessMessage
    # @!attribute flags
    #   @return [String]
    oattr :flags, :scalar

    # @!attribute result
    #   @return [String]
    oattr :result, :scalar

    # @!attribute suggested_correction
    #   @return [String]
    oattr :suggested_correction, :scalar

    # @!attribute address_info
    #   @return [AddressInfo]
    #   @return [nil]
    oattr :address_info, :writer

    # @!attribute credits_info
    #   @return [CreditsInfo::Monthly]
    #   @return [CreditsInfo::Paid]
    #   @return [nil]
    oattr :credits_info, :writer

    def address_info
      igetset(:address_info) do
        if body_hash.has_key?(k = "address_info")
          Response::AddressInfo.new(body_hash: body_hash.fetch(k))
        end
      end
    end

    # <tt>true</tt> if {#address_info} is present.
    def address_info?
      !address_info.nil?
    end

    def credits_info
      igetset(:credits_info) do
        if (body_hash.has_key?(k = "credits_info"))
          h = body_hash.fetch(k)
          klass = if h.has_key? "monthly_api_usage"
            CreditsInfo::Monthly
          elsif h.has_key? "paid_credits_remaining"
            CreditsInfo::Paid
          else
            raise "Unknown `credits_info`: #{h.inspect}"
          end

          klass.new(h)
        end
      end
    end

    # <tt>true</tt> if {#credits_info} is present.
    def credits_info?
      !credits_info.nil?
    end
  end
end; end; end

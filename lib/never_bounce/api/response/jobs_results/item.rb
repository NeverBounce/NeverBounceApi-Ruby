
require "never_bounce/api/response/address_info"
require "never_bounce/api/response/container"

require_relative "../jobs_results"

module NeverBounce; module API; module Response; class JobsResults
  class Item < Container
    # @!attribute address_info
    #   @return [AddressInfo]
    oattr :address_info, :writer

    # @!attribute data
    #   @return [Hash]
    oattr :data, :writer

    # @!attribute email
    #   @return [String]
    oattr :email, :writer

    # @!attribute flags
    #   @return [Array<String>]
    oattr :flags, :writer

    # @!attribute result
    #   @return [String]
    oattr :result, :writer

    # @!attribute suggested_correction
    #   @return [String]
    oattr :suggested_correction, :writer

    def address_info
      @address_info = AddressInfo.new(body_hash: body_hash.fetch("verification").fetch("address_info"))
    end

    def email
      @email ||= data["email"]
    end

    def flags
      @flags ||= body_hash.fetch("verification").fetch("flags")
    end

    def data
      @data ||= body_hash.fetch("data")
    end

    def result
      @result ||= body_hash.fetch("verification").fetch("result")
    end

    def suggested_correction
      @suggested_correction ||= body_hash.fetch("verification").fetch("suggested_correction")
    end
  end
end; end; end; end

#
# Implementation notes:
#
# * I use a more streamlined structure here, not reflecting API JSON reply structure.
#   I skip `verification` key entirely, since it has zero value to client code.
# * According to API spec, `data` has varying keys based on originally uploaded CSV.
# * We extract some important keys like `email` from `data`. `data` stays intact.


require_relative "container"

module NeverBounce; module API; module Response
  # Generic address info used in a number of responses.
  class AddressInfo < Container
    # @!attribute addr
    #   @return [String]
    oattr :addr, :scalar

    # @!attribute alias
    #   @return [String]
    oattr :alias, :scalar

    # @!attribute domain
    #   @return [String]
    oattr :domain, :scalar

    # @!attribute fqdn
    #   @return [String]
    oattr :fqdn, :scalar

    # @!attribute host
    #   @return [String]
    oattr :host, :scalar

    # @!attribute normalized_email
    #   @return [String]
    oattr :normalized_email, :scalar

    # @!attribute original_email
    #   @return [String]
    oattr :original_email, :scalar

    # @!attribute subdomain
    #   @return [String]
    oattr :subdomain, :scalar

    # @!attribute tld
    #   @return [String]
    oattr :tld, :scalar
  end
end; end; end

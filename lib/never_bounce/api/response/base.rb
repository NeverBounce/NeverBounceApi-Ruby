
require "never_bounce/api/feature/basic_initialize"
require "never_bounce/api/feature/igetset"
require "never_bounce/api/feature/require_attr"

module NeverBounce; module API; module Response
  # @see API::Feature::BasicInitialize
  # @see API::Feature::Igetset
  # @see API::Feature::RequireAttr
  class Base
    API::Feature::BasicInitialize.load(self)
    API::Feature::Igetset.load(self)
    API::Feature::RequireAttr.load(self)
  end
end; end; end

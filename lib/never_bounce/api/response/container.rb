
require "json"

require "never_bounce/api/feature/eigencache"
require "never_bounce/api/feature/oattrs"
require "never_bounce/api/feature/require_attr"

require_relative "base"

module NeverBounce; module API; module Response
  # A container with values, by default supports JSON parsing.
  # @see API::Feature::Eigencache
  # @see API::Feature::Oattrs
  # @see API::Feature::RequireAttr
  class Container < Base
    API::Feature::Eigencache.load(self)
    API::Feature::Oattrs.load(self)
    API::Feature::RequireAttr.load(self)

    # Container data. Default is JSON-parsed {#raw}.
    # @!attribute body_hash
    # @return [Hash]
    def body_hash
      _cache[:body_hash] ||= JSON.parse(require_attr(:raw))
    end

    def body_hash=(value)
      _cache[:body_hash] = value
    end

    # Raw response body.
    # @!attribute raw
    # @return [String]
    def raw
      _cache[:raw]
    end

    def raw=(value)
      _cache[:raw] ||= value
    end

    #--------------------------------------- Misc

    class << self
      private

      # Declare & register an oattr.
      #
      #   oattr :first_name, :scalar    # => :first_name
      #   oattr ...                     # Handled by `Feature::Oattrs`.
      #
      # @return [Symbol] <tt>name</tt>.
      # @see Feature::Oattrs::ClassMethods#oattr
      def oattr(name, type, *args)
        if type == :scalar
          scalar_oattr(name, *args)
          name.tap { oattrs << name }
        else
          # Handle other types in parent class.
          super
        end
      end

      # Build a generic scalar oattr.
      #
      #   scalar_oattr :first_name
      #   scalar_oattr :page, type: :integer
      #   scalar_oattr :total_valid, type: :integer, allow_nil: true
      #
      # @return [Symbol]
      def scalar_oattr(name, options = {})
        o, options = {}, options.dup
        o[k = :allow_nil] = options.include?(k) ? options.delete(k) : false
        o[k = :key] = options.delete(k) || name
        o[k = :type] = options.delete(k) || :any
        raise ArgumentError, "Unknown options: #{options.inspect}" if not options.empty?

        code = []
        code << %{attr_writer :#{name}}

        code << case o[:type]
          when :any
            %{def #{name}; @#{name} ||= body_hash.fetch("#{o[:key]}"); end}
          when :float
            if o[:allow_nil]
              %{
                def #{name}
                  @#{name} ||= unless (v = body_hash.fetch("#{o[:key]}")).nil?
                    Float(v)
                  end
                end
              }
            else
              %{def #{name}; @#{name} ||= Float(body_hash.fetch("#{o[:key]}")); end}
            end
          when :integer
            if o[:allow_nil]
              %{
                def #{name}
                  @#{name} ||= unless (v = body_hash.fetch("#{o[:key]}")).nil?
                    Integer(v)
                  end
                end
              }
            else
              %{def #{name}; @#{name} ||= Integer(body_hash.fetch("#{o[:key]}")); end}
            end
          else
            raise ArgumentError, "Unknown type: #{o[:type].inspect}"
          end

        class_eval code.join(";")

        name
      end
    end # class << self
  end
end; end; end

#
# Implementation notes:
#
# * I go for `class_eval` rather than `define_method` in order to use Ruby's `||=`.
#   Going without it would require a bunch of `instance_variable_*` calls per each attribute access.
# * The container performs its own value validation according to attribute definitions.
#   Thus, when creating a sub-container, it's more correct to pass `body` or `body_hash` to let this validation happen in the sub-container class.

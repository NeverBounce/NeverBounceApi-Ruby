
module NeverBounce; module API; module Feature
  # Declare and manage on-the-fly (OTF) attributes of the class, codenamed "oattrs".
  # @see ClassMethods#oattr
  # @see ClassMethods#oattrs
  # @see InstanceMethods#touch
  module Oattrs
    # @return [nil]
    def self.load(owner)
      return if owner < InstanceMethods
      owner.extend(ClassMethods)
      owner.send(:include, InstanceMethods)
    end

    module ClassMethods
      # Return oattrs declared so far, recurse all superclasses.
      #
      #   oattrs    # => [:first_name, :last_name]
      #
      # @!attribute oattrs
      # @return [Array]
      def oattrs
        @attrs ||= if superclass.respond_to?(m = :oattrs)
          superclass.send(m).dup
        else
          []
        end
      end

      def oattrs=(ar)
        @oattrs = ar
      end

      # Declare an OTF attribute.
      #
      #   class Klass
      #     oattr :first_name, :writer
      #     oattr :goods, :custom
      #
      #     def first_name
      #       @first_name ||= ENV["FIRST_NAME"]
      #     end
      #
      #     def goods
      #       @goods ||= ...
      #
      #     def goods=(ar)
      #       @goods = ar
      #     ...
      #
      # @return [Symbol] <tt>name</tt>.
      # @see InstanceMethods#touch
      def oattr(name, type)
        case type
        when :custom
          # Do nothing, just register attr below.
        when :writer
          attr_writer name
        else
          raise ArgumentError, "Unknown type: #{type.inspect}"
        end

        # Register and return.
        name.tap { oattrs << name}
      end
    end

    module InstanceMethods
      # Load all oattrs by "touching" them.
      #
      #   irb> resp = client.jobs_delete(job_id: 353701)
      #   => #<NeverBounce::API::Response::ErrorMessage:0x0056245978aec8>
      #   irb> resp.touch
      #   => #<NeverBounce::API::Response::ErrorMessage:0x0056245978aec8 @message="Invalid job ID 353701", @execution_time=15, @status="general_failure">
      #
      # @return [self]
      def touch
        self.class.oattrs.each do |name|
          v = public_send(name)

          # Touch recursively. Support simple collections.
          if v.respond_to? :touch
            v.touch
          elsif v.is_a? Array
            v.each { |r| r.touch if r.respond_to? :touch }
          end
        end

        self
      end
    end
  end
end; end; end

#
# Implementation notes:
#
# * Originally I've used `attr` and `attrs` as method names.
#   Sadly enough, YARD choked on `attr ...` with no reasonable way to work around it and tell it to ignore these statements.
#   That led me to the conclusion that `attr` acts more like a language construct, so I'd rather not override it, but make my own.

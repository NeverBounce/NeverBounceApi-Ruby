
require "never_bounce/api/error"

module NeverBounce; module API; module Feature
  # Provide attribute validation method(s) to the owner class.
  # @see InstanceMethods#initialize
  module RequireAttr
    # @param owner [Class]
    # @return [nil]
    def self.load(owner)
      return if owner < InstanceMethods
      owner.send(:include, InstanceMethods)
    end

    module InstanceMethods
      private

      # Require attribute to be set. Return attribute value.
      # @return [mixed]
      def require_attr(name)
        send(name).tap do |_|
          raise AttributeError, "Attribute must be set: #{name}" if attr_nil?(_)
        end
      end

      def attr_nil?(attr)
        attr.is_a?(HTTParty::Response) ? attr.body.nil? : attr.nil?
      end
    end
  end
end; end; end

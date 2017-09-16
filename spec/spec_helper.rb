
# Start SimpleCov BEFORE ALL if it's enabled in Gemlocal.
require_relative "spec_support/simplecov"

# Optionally include developer-local spec helper.
File.readable?(fn = File.expand_path("spec_local.rb", __dir__)) and require fn

# Load support files.
Dir[File.expand_path("spec_support/**/*.rb", __dir__)].each { |fn| require fn }

# Require our entire library, just like the client would do.
require "neverbounce"

# Require all `spec_helper.rb` throughout the tree for shared contexts.
Dir[File.expand_path("**/spec_helper.rb", __dir__)].each { |fn| require fn }

# Uncomment when there's need to configure RSpec.
#RSpec.configure do |conf|
#end

# Absolutely common shared context.
shared_context __dir__ do
  shared_examples "instantiatable" do
    it { expect(described_class.new).to be_a described_class }
  end

  let(:cllggr) do
    # Instance of this class logs every method call and allows to retrieve the calls.
    # @see #_calls
    Class.new do
      # Calls logger so far.
      # @return [Array]
      def _calls
        @_calls ||= []
      end

      # Return number of calls so far, including this one.
      # @return [Integer]
      def method_missing(m, *args, &block)
        (_calls << [m, args, block].compact).size
      end
    end
  end

  # General-purpose "create new object".
  def newo(attrs = {})
    described_class.new(attrs)
  end
end


module NeverBounce; module API; module Feature
  describe RequireAttr do
    let(:klass) do
      feature = described_class
      Class.new do
        feature.load(self)

        attr_accessor :a, :p

        def b
          v = require_attr :a
          [v, "b"]
        end

        def c
          v = require_attr :p
          [v, 'c']
        end
      end
    end

    it "generally works" do
      r = klass.new
      expect { r.b }.to raise_error(AttributeError, "Attribute must be set: a")
      r.a = HTTParty::Response.new(
        double('Request', options: {}),
        double('Response', body: 'foo', to_hash: {}),
        double('ParsedOptions', call: {})
      )

      expect(r.b).to eq [r.a, "b"]
    end
  end
end; end; end

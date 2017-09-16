
module NeverBounce; module API; module Feature
  describe RequireAttr do
    let(:klass) do
      feature = described_class
      Class.new do
        feature.load(self)

        attr_accessor :a

        def b
          v = require_attr :a
          [v, "b"]
        end
      end
    end

    it "generally works" do
      r = klass.new
      expect { r.b }.to raise_error(AttributeError, "Attribute must be set: a")
      r.a = "a"
      expect(r.b).to eq ["a", "b"]
    end
  end
end; end; end

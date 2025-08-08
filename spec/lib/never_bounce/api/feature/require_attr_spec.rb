
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

    it "doesn't trip HTTParty's deprecation warning on #nil?" do
      request = instance_double(HTTParty::Request, options: {})
      response = instance_double(Net::HTTPResponse, body: nil, to_hash: {})
      parsed_block = lambda { nil }

      server_obj = HTTParty::Response.new(request, response, parsed_block)

      r = klass.new
      r.a = server_obj

      expect { r.b }.not_to output(/DEPRECATION/).to_stderr
    end
  end
end; end; end


module NeverBounce; module API
  describe Session do
    include_dir_context __dir__

    it_behaves_like "instantiatable"

    describe "#server_raw" do
      let(:m) { :server_raw }
      context "when NOK" do
        it "generally works" do
          r = newo(
            server_obj: Class.new do
              def code; 123; end
              def ok?; false; end
            end.new
          )
          expect { r.send(m) }.to raise_error(RequestError, "Code not OK: 123")
        end
      end

      context "when OK" do
        it "generally works" do
          r = newo(
            server_obj: Class.new do
              def body; "abc"; end
              def ok?; true; end
            end.new,
          )
          expect(r.send(m)).to eq "abc"
        end
      end
    end # describe "#server_raw"

    describe "#robj_hash_preview" do
      let(:m) { :robj_hash_preview }

      context "when unknown content type" do
        it "generally works" do
          r = newo(server_content_type: "type/a")
          expect(r.send(m)).to be false
        end
      end

      context "when 'application/json'" do
        it "generally works" do
          r = newo(
            server_content_type: "application/json",
            server_raw: "xyz",
          )
          expect { r.send(m) }.to raise_error(FormatError, /^JSON::ParserError: /)

          r = newo(
            server_content_type: "application/json",
            server_raw: '{"a":12,"b":"abc"}',
          )
          expect(r.send(m)).to eq({"a" => 12, "b" => "abc"})
        end
      end
    end
      it "generally works" do
    end

    describe "#robj_klass_and_attrs" do
      let(:m) { :robj_klass_and_attrs }

      # A minimum viable instance for tests below.
      def newo(attrs = {})
        request_klass = Class.new do
          def self.response_klass; Response::JobsParse; end
        end

        Class.new(described_class) do
          def server_obj; raise "This must never be called"; end
        end.new({
          request: request_klass.new,
          #server_content_type: "server_content_type",
          server_raw: "server_raw",
        }.merge(attrs))
      end

      it "validates `robj_hash_preview`" do
        r = newo(robj_hash_preview: "abc")
        expect { r.send(m) }.to raise_error(AttributeError, "Unknown `robj_hash_preview`: \"abc\"")
      end

      it "works for raw data" do
        r = newo(
          robj_hash_preview: false,
          #server_content_type: "application/octet-stream",
        )
        #expect { r.send(m) }.to raise_error(FormatError, /^Key 'status' not found: /)
        expect(r.send(m)).to eq [Response::JobsParse, {:raw => "server_raw"}]
      end

      it "works for invalid data" do
        # Valid JSON.
        r = newo(
          robj_hash_preview: {"a" => 12},
          #server_content_type: "application/json",
        )
        expect { r.send(m) }.to raise_error(FormatError, /^Key 'status' not found: /)
      end

      it "works for valid data" do
        r = newo(
          robj_hash_preview: {"status" => "success"},
          #server_content_type: "application/json",
        )
        expect(r.send(m)).to eq [Response::JobsParse, {:body_hash=>{"status"=>"success"}}]

        r = newo(
          robj_hash_preview: {"status" => "not-a-success"},   # Not necessarily "error".
          #server_content_type: "application/json",
        )
        expect(r.send(m)).to eq [Response::ErrorMessage, {:body_hash=>{"status"=>"not-a-success"}}]
      end
    end

    describe "#server_obj" do
      it "requires `request`" do
        r = newo
        expect { r.server_obj }.to raise_error "Attribute must be set: request"
      end

      it "generally works" do
        # See implementation notes below.
        r = newo(
          httparty: (httparty = cllggr.new),
          request: Request::JobsParse.new(api_key: "api_key", job_id: "123"),
        )
        expect(r.server_obj).to eq 1    # Result of `cllggr`.
        #args = httparty._calls[0]
        #expect(args).to be_a Array
        #expect(args).not_to be_empty
      end
    end
  end
end; end

# Implementation notes:
#
# * We test class's general abilities on a real request class.
# * Consider this great hack to debug tests easier:
#     Class.new(described_class) do
#      def server_obj; raise "This must never be called"; end
#    end.new(...)

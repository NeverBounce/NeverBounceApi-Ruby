
module NeverBounce; module API; module Request
  describe JobsCreate do
    include_dir_context __dir__

    it_behaves_like "instantiatable"

    describe "#mode_h" do
      it "generally works" do
        r = newo()
        expect(r.mode_h).to eq({})
        r = newo(auto_start: nil, auto_parse: nil, run_sample: nil)
        expect(r.mode_h).to eq({})
        r = newo(auto_start: false, auto_parse: false, run_sample: false)
        expect(r.mode_h).to eq({auto_start: false, auto_parse: false, run_sample: false})
        r = newo(auto_start: true, auto_parse: true, run_sample: true)
        expect(r.mode_h).to eq({auto_start: true, auto_parse: true, run_sample: true})
      end
    end

    describe ".response_klass" do
      it { expect(described_class.response_klass).to eq API::Response::JobsCreate }
    end

    describe "#to_h" do
      let(:m) { :to_h }
      context "for input specification" do
        def goodo(attrs = {})
          newo({
            api_key: "api_key",
            filename: "filename",
          }.merge(attrs))
        end

        it "generally works" do
          # NOTE: Logical order: type, then value.
          r = goodo(input_location: "unk", input: "input")
          expect { r.send(m) }.to raise_error(AttributeError, 'Unknown `input_location`: "unk"')

          r = goodo(input_location: "remote_url", input: "input")
          expect(h = r.send(m)).to be_a Hash
          expect(h).to include(input_location: "remote_url", input: "input")

          r = goodo(input_location: "supplied", input: "plain")
          expect { r.send(m) }.to raise_error(AttributeError, 'Invalid `input` for `input_location` == "supplied": "plain"')

          r = goodo(input_location: "supplied", input: ["a", "b"])
          expect { r.send(m) }.to raise_error(AttributeError, 'Invalid `input` element: "a"')

          r = goodo(input_location: "supplied", input: [["a"], ["b"]])
          expect { r.send(m) }.to raise_error(AttributeError, 'Invalid `input` element: ["a"]')

          r = goodo(input_location: "supplied", input: [["tom@isp.com", "Tom User"], ["b"]])
          expect { r.send(m) }.to raise_error(AttributeError, 'Invalid `input` element: ["b"]')

          r = goodo(input_location: "supplied", input: [["tom@isp.com", "Tom User"], ["b", "bb", "bbb"]])
          expect { r.send(m) }.to raise_error(AttributeError, 'Invalid `input` element: ["b", "bb", "bbb"]')

          r = goodo(input_location: "supplied", input: [["tom@isp.com", "Tom User"], ["dick@gmail.com", "Dick Other"]])
          expect(h = r.send(m)).to be_a Hash
          expect(h).to include(input: [["tom@isp.com", "Tom User"], ["dick@gmail.com", "Dick Other"]])
        end
      end
    end

    describe "#to_httparty" do
      it "generally works" do
        r = newo
        expect { r.to_httparty }.to raise_error(AttributeError, "Attribute must be set: input")
        r.input = "input"
        expect { r.to_httparty }.to raise_error(AttributeError, "Attribute must be set: input_location")
        r.input_location = "remote_url"
        expect { r.to_httparty }.to raise_error(AttributeError, "Attribute must be set: filename")
        r.filename = "filename"
        expect { r.to_httparty }.to raise_error(AttributeError, "Attribute must be set: api_key")
        r.api_key = "api_key"

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(method).to eq :post
        expect(url).to eq "https://api.neverbounce.com/v4/jobs/create"
        expect(data).to include(:body, :headers)
        expect(data.fetch(:body)).to eq "{\"input\":\"input\",\"input_location\":\"remote_url\",\"filename\":\"filename\",\"key\":\"api_key\"}"
        expect(data.fetch(:headers)).to include("Content-Type", "User-Agent")
      end
    end
  end
end; end; end

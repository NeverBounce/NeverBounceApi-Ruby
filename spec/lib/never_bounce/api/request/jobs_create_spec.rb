
module NeverBounce; module API; module Request
  describe JobsCreate do
    include_dir_context __dir__

    it_behaves_like "instantiatable"

    describe "#mode_h" do
      it "generally works" do
        r = newo()
        expect(r.mode_h).to eq({})
        r = newo(auto_start: nil, auto_parse: nil, run_sample: nil, allow_manual_review: nil)
        expect(r.mode_h).to eq({})
        r = newo(auto_start: false, auto_parse: false, run_sample: false)
        expect(r.mode_h).to eq({auto_start: false, auto_parse: false, run_sample: false})
        r = newo(auto_start: true, auto_parse: true, run_sample: true)
        expect(r.mode_h).to eq({auto_start: true, auto_parse: true, run_sample: true})
        r = newo(historical: true)
        expect(r.mode_h).to eq({request_meta_data: {leverage_historical_data: true}})
        r = newo(historical: false)
        expect(r.mode_h).to eq({request_meta_data: {leverage_historical_data: false}})
        r = newo(allow_manual_review: true, callback_url: "http://test.com", callback_headers: {:Authorization => "Basic test"})
        expect(r.mode_h).to eq({allow_manual_review: true, callback_url: "http://test.com", callback_headers: {:Authorization => "Basic test"}})
        r = newo(allow_manual_review: false, callback_url: nil, callback_headers: nil)
        expect(r.mode_h).to eq({allow_manual_review: false})
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

          r = goodo(input_location: "supplied", input: [["alice@isp.com", "Alice Roberts"], ["b"]])
          expect { r.send(m) }.to raise_error(AttributeError, 'Invalid `input` element: ["b"]')

          r = goodo(input_location: "supplied", input: [["alice@isp.com", "Alice Roberts"], ["b", "bb", "bbb"]])
          expect { r.send(m) }.to raise_error(AttributeError, 'Invalid `input` element: ["b", "bb", "bbb"]')

          r = goodo(input_location: "supplied", input: [["alice@isp.com", "Alice Roberts"], ["bob.smith@gmail.com", "Bob Smith"]])
          expect(h = r.send(m)).to be_a Hash
          expect(h).to include(input: [["alice@isp.com", "Alice Roberts"], ["bob.smith@gmail.com", "Bob Smith"]])
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
        expect(url).to eq "https://api.neverbounce.com/v4.2/jobs/create"
        expect(data).to include(:body, :headers)
        expect(data.fetch(:body)).to eq "{\"input\":\"input\",\"input_location\":\"remote_url\",\"filename\":\"filename\",\"key\":\"api_key\"}"
        expect(data.fetch(:headers)).to include("Content-Type", "User-Agent")
      end

      it "allows historical to be disabled" do
        r = newo
        r.input = "input"
        r.input_location = "remote_url"
        r.filename = "filename"
        r.api_key = "api_key"
        r.historical = false

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(data.fetch(:body)).to eq "{\"input\":\"input\",\"input_location\":\"remote_url\",\"filename\":\"filename\",\"key\":\"api_key\",\"request_meta_data\":{\"leverage_historical_data\":false}}"
      end

      it "allows historical to be explicitly enabled" do
        r = newo
        r.input = "input"
        r.input_location = "remote_url"
        r.filename = "filename"
        r.api_key = "api_key"
        r.historical = true

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(data.fetch(:body)).to eq "{\"input\":\"input\",\"input_location\":\"remote_url\",\"filename\":\"filename\",\"key\":\"api_key\",\"request_meta_data\":{\"leverage_historical_data\":true}}"
      end

      it "allows allow manual review parameter to be enabled" do
        r = newo
        r.input = "input"
        r.input_location = "remote_url"
        r.filename = "filename"
        r.api_key = "api_key"
        r.allow_manual_review = true

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(data.fetch(:body)).to eq "{\"input\":\"input\",\"input_location\":\"remote_url\",\"filename\":\"filename\",\"key\":\"api_key\",\"allow_manual_review\":true}"
      end

      it "allows allow manual review parameter to be disabled" do
        r = newo
        r.input = "input"
        r.input_location = "remote_url"
        r.filename = "filename"
        r.api_key = "api_key"
        r.allow_manual_review = false

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(data.fetch(:body)).to eq "{\"input\":\"input\",\"input_location\":\"remote_url\",\"filename\":\"filename\",\"key\":\"api_key\",\"allow_manual_review\":false}"
      end

      it "allows callback url and headers" do
        r = newo
        r.input = "input"
        r.input_location = "remote_url"
        r.filename = "filename"
        r.api_key = "api_key"
        r.callback_url = "http://test.com"
        r.callback_headers = {:Authorization => "Basic test"}

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(data.fetch(:body)).to eq "{\"input\":\"input\",\"input_location\":\"remote_url\",\"filename\":\"filename\",\"key\":\"api_key\",\"callback_url\":\"http://test.com\",\"request_meta_data\":{\"Authorization\":\"Basic test\"}}"
      end
    end
  end
end; end; end

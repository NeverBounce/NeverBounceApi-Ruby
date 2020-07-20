
module NeverBounce; module API; module Request
  describe SingleCheck do
    include_dir_context __dir__

    it_behaves_like "instantiatable"

    describe "#mode_h" do
      it "generally works" do
        r = newo()
        expect(r.mode_h).to eq({})
        r = newo(address_info: nil, credits_info: nil, timeout: nil)
        expect(r.mode_h).to eq({})
        r = newo(address_info: false, credits_info: false)
        expect(r.mode_h).to eq({address_info: false, credits_info: false})
        r = newo(address_info: true, credits_info: true, timeout: 12)
        expect(r.mode_h).to eq({address_info: true, credits_info: true, timeout: 12})
        r = newo(historical: true)
        expect(r.mode_h).to eq({request_meta_data: {leverage_historical_data: true}})
        r = newo(historical: false)
        expect(r.mode_h).to eq({request_meta_data: {leverage_historical_data: false}})
      end
    end

    describe ".response_klass" do
      it { expect(described_class.response_klass).to eq Response::SingleCheck }
    end

    describe "#to_httparty" do
      it "generally works" do
        r = newo(address_info: true, credits_info: true, timeout: 12)
        expect { r.to_httparty }.to raise_error(AttributeError, "Attribute must be set: email")
        r.email = "email"
        expect { r.to_httparty }.to raise_error(AttributeError, "Attribute must be set: api_key")
        r.api_key = "api_key"

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(method).to eq :get
        expect(url).to eq "https://api.neverbounce.com/v4.2/single/check"
        expect(data).to include(:body, :headers)
        expect(data.fetch(:body)).to eq "{\"email\":\"email\",\"key\":\"api_key\",\"address_info\":true,\"credits_info\":true,\"timeout\":12}"
        expect(data.fetch(:headers)).to include("Content-Type", "User-Agent")
      end

      it "allows historical to be disabled" do
        r = newo(address_info: true, credits_info: true, timeout: 12, historical: false)
        r.email = "email"
        r.api_key = "api_key"

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(data.fetch(:body)).to eq "{\"email\":\"email\",\"key\":\"api_key\",\"address_info\":true,\"credits_info\":true,\"timeout\":12,\"request_meta_data\":{\"leverage_historical_data\":false}}"
      end

      it "allows historical to be explicitly enabled" do
        r = newo(address_info: true, credits_info: true, timeout: 12, historical: true)
        r.email = "email"
        r.api_key = "api_key"

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(data.fetch(:body)).to eq "{\"email\":\"email\",\"key\":\"api_key\",\"address_info\":true,\"credits_info\":true,\"timeout\":12,\"request_meta_data\":{\"leverage_historical_data\":true}}"
      end
    end
  end
end; end; end

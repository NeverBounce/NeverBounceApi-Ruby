
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
        expect(url).to eq "https://api.neverbounce.com/v4/single/check"
        expect(data).to include(:body, :headers)
        expect(data.fetch(:body)).to eq "{\"email\":\"email\",\"key\":\"api_key\",\"address_info\":true,\"credits_info\":true,\"timeout\":12}"
        expect(data.fetch(:headers)).to include("Content-Type", "User-Agent")
      end
    end
  end
end; end; end

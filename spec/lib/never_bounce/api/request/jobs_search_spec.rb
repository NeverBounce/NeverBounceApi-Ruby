
module NeverBounce; module API; module Request
  describe JobsSearch do
    include_dir_context __dir__

    it_behaves_like "instantiatable"

    describe "#mode_h" do
      it "generally works" do
        r = newo()
        expect(r.mode_h).to eq({})
        r = newo(job_id: nil, page: nil, per_page: nil)
        expect(r.mode_h).to eq({})
        r = newo(job_id: "abc", page: 12, per_page: 34)
        expect(r.mode_h).to eq({job_id: "abc", page: 12, items_per_page: 34})
      end
    end

    describe ".response_klass" do
      it { expect(described_class.response_klass).to eq API::Response::JobsSearch }
    end

    describe "#to_httparty" do
      it "generally works" do
        r = newo(job_id: "abc", page: 12, per_page: 34)
        expect { r.to_httparty }.to raise_error(AttributeError, "Attribute must be set: api_key")
        r.api_key = "api_key"

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(method).to eq :get
        expect(url).to eq "https://api.neverbounce.com/v4/jobs/search"
        expect(data).to include(:body, :headers)
        expect(data.fetch(:body)).to eq "{\"key\":\"api_key\",\"job_id\":\"abc\",\"page\":12,\"items_per_page\":34}"
        expect(data.fetch(:headers)).to include("Content-Type", "User-Agent")
      end
    end
  end
end; end; end

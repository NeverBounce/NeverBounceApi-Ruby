
module NeverBounce; module API; module Request
  describe JobsStatus do
    include_dir_context __dir__

    it_behaves_like "instantiatable"

    describe ".response_klass" do
      it { expect(described_class.response_klass).to eq API::Response::JobsStatus }
    end

    describe "#to_httparty" do
      it "generally works" do
        r = newo
        expect { r.to_httparty }.to raise_error(AttributeError, "Attribute must be set: job_id")
        r.job_id = "123"
        expect { r.to_httparty }.to raise_error(AttributeError, "Attribute must be set: api_key")
        r.api_key = "api_key"

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(method).to eq :get
        expect(url).to eq "https://api.neverbounce.com/v4/jobs/status"
        expect(data).to include(:body, :headers)
        expect(data.fetch(:body)).to eq "{\"job_id\":\"123\",\"key\":\"api_key\"}"
        expect(data.fetch(:headers)).to include("Content-Type", "User-Agent")
      end
    end
  end
end; end; end

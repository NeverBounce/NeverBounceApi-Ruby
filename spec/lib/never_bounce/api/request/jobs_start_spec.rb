
module NeverBounce; module API; module Request
  describe JobsStart do
    include_dir_context __dir__

    it_behaves_like "instantiatable"

    describe "#mode_h" do
      it "generally works" do
        r = newo()
        expect(r.mode_h).to eq({})
        r = newo(run_sample: nil, allow_manual_review: nil)
        expect(r.mode_h).to eq({})
        r = newo(run_sample: false, allow_manual_review: false)
        expect(r.mode_h).to eq({run_sample: false, allow_manual_review: false})
        r = newo(run_sample: true, allow_manual_review: true)
        expect(r.mode_h).to eq({run_sample: true, allow_manual_review: true})
      end
    end

    describe ".response_klass" do
      it { expect(described_class.response_klass).to eq Response::JobsStart }
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
        expect(method).to eq :post
        expect(url).to eq "https://api.neverbounce.com/v4.2/jobs/start"
        expect(data).to include(:body, :headers)
        expect(data.fetch(:body)).to eq("{\"job_id\":\"123\",\"key\":\"api_key\"}")
        expect(data.fetch(:headers)).to include("Content-Type", "User-Agent")
      end

      it "allows allow manual review parameter to be enabled" do
        r = newo
        r.job_id = "123"
        r.api_key = "api_key"
        r.allow_manual_review = true

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(data.fetch(:body)).to eq "{\"job_id\":\"123\",\"key\":\"api_key\",\"allow_manual_review\":true}"
      end

      it "allows allow manual review parameter to be disabled" do
        r = newo
        r.job_id = "123"
        r.api_key = "api_key"
        r.allow_manual_review = false

        res = r.to_httparty
        expect(res).to be_a Array
        method, url, data = res
        expect(data.fetch(:body)).to eq "{\"job_id\":\"123\",\"key\":\"api_key\",\"allow_manual_review\":false}"
      end
    end
  end
end; end; end

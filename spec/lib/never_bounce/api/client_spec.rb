
module NeverBounce; module API
  describe Client do
    include_dir_context __dir__

    it_behaves_like "instantiatable"

    describe "attributes" do
      describe "#api_key" do
        it "generally works" do
          r = newo
          expect { r.api_key }.to raise_error(AttributeError, "Attribute must be set: api_key")
          r.api_key = "api_key"
          expect(r.api_key).to eq "api_key"
        end
      end
    end # describe "attributes"

    describe "requests" do
      let(:klass) do
        Class.new(described_class) do
          def response_to(request)
            # Short-circuit with a signature. The signature ensures we get control here.
            [:response_to, request]
          end
        end
      end

      # Build a "good" object with typically enough attributes to work.
      def goodo(attrs = {})
        klass.new({
          api_key: "api_key",
        }.merge(attrs))
      end

      describe "#account_info" do
        it "generally works" do
          sc = goodo.account_info
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::AccountInfo
          expect(request.to_httparty).to be_a Array
        end
      end

      describe "#jobs_create" do
        let(:m) { :jobs_create }
        it "generally works" do
          client = goodo
          expect { client.send(m) }.to raise_error(ArgumentError, "Input not given, use `remote_input` or `supplied_input`")

          client = goodo
          expect { client.send(m, remote_input: "remote", supplied_input: "supplied") }.to raise_error(ArgumentError, "`remote_input` and `supplied_input` can't both be given")

          # NOTE: A few scenarios, redundantly testing as much attributes as possible.

          sc = client.send(m, remote_input: "remote_input")
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsCreate
          expect(request.to_httparty).to be_a Array
          expect(request.input).to eq "remote_input"
          expect(request.input_location).to eq "remote_url"
          expect(request.filename).to match /^\d{8}-\d{6}\.csv$/

          sc = client.send(m, supplied_input: [["email", "name"]])
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsCreate
          expect(request.to_httparty).to be_a Array
          expect(request.input).to eq [["email", "name"]]
          expect(request.input_location).to eq "supplied"
          expect(request.filename).to match /^\d{8}-\d{6}\.csv$/

          sc = client.send(m, auto_parse: true, auto_start: true, filename: "filename", run_sample: true, supplied_input: [["email", "name"]])
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsCreate
          expect(request.to_httparty).to be_a Array
          expect(request.auto_parse).to be true
          expect(request.auto_start).to be true
          expect(request.input).to eq [["email", "name"]]
          expect(request.input_location).to eq "supplied"
          expect(request.filename).to eq "filename"
          expect(request.run_sample).to be true
        end
      end

      describe "#jobs_delete" do
        it "generally works" do
          sc = goodo.jobs_delete(job_id: 12)
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsDelete
          expect(request.to_httparty).to be_a Array
          expect(request.job_id).to eq 12
        end
      end

      describe "#jobs_download" do
        it "generally works" do
          sc = goodo.jobs_download(job_id: 12)
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsDownload
          expect(request.to_httparty).to be_a Array
          expect(request.job_id).to eq 12
        end
      end

      describe "#jobs_parse" do
        it "generally works" do
          sc = goodo.jobs_parse(auto_start: true, job_id: 12)
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsParse
          expect(request.to_httparty).to be_a Array
          expect(request.auto_start).to be true
          expect(request.job_id).to eq 12
        end
      end

      describe "#jobs_results" do
        it "generally works" do
          sc = goodo.jobs_results(job_id: 12, page: 34, per_page: 56)
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsResults
          expect(request.to_httparty).to be_a Array
          expect(request.job_id).to eq 12
          expect(request.page).to eq 34
          expect(request.per_page).to eq 56
        end
      end

      describe "#jobs_search" do
        it "generally works" do
          sc = goodo.jobs_search(job_id: 12, page: 34, per_page: 56)
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsSearch
          expect(request.to_httparty).to be_a Array
          expect(request.job_id).to eq 12
          expect(request.page).to eq 34
          expect(request.per_page).to eq 56
        end
      end

      describe "#jobs_start" do
        it "generally works" do
          sc = goodo.jobs_start(job_id: 12, run_sample: true)
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsStart
          expect(request.to_httparty).to be_a Array
          expect(request.job_id).to eq 12
          expect(request.run_sample).to be true
        end
      end

      describe "#jobs_status" do
        it "generally works" do
          sc = goodo.jobs_status(job_id: 12)
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::JobsStatus
          expect(request.to_httparty).to be_a Array
          expect(request.job_id).to eq 12
        end
      end

      describe "#single_check" do
        it "generally works" do
          sc = goodo.single_check(address_info: true, credits_info: true, email: "alice@isp.com", timeout: 12)
          expect(sc).to be_a Array
          signature, request = sc
          expect(signature).to eq :response_to
          expect(request).to be_a Request::SingleCheck
          expect(request.to_httparty).to be_a Array
          expect(request.address_info).to be true
          expect(request.credits_info).to be true
          expect(request.email).to eq "alice@isp.com"
          expect(request.timeout).to eq 12
        end
      end
    end
  end
end; end

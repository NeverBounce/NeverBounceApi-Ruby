
<p align="center"><img src="https://neverbounce-marketing.s3.amazonaws.com/neverbounce_color_600px.png"></p>

<p align="center">
  <a href="https://badge.fury.io/rb/neverbounce-api"><img src="https://badge.fury.io/rb/neverbounce-api.svg" alt="Gem Version"></a>
  <a href="https://travis-ci.org/NeverBounce/NeverBounceApi-Ruby"><img src="https://travis-ci.org/NeverBounce/NeverBounceApi-Ruby.svg" alt="Build Status"></a>
  <a href="https://codeclimate.com/github/NeverBounce/NeverBounceApi-Ruby/coverage"><img src="https://codeclimate.com/github/NeverBounce/NeverBounceApi-Ruby/badges/coverage.svg" /></a>
  <a href="https://codeclimate.com/github/NeverBounce/NeverBounceApi-Ruby"><img src="https://codeclimate.com/github/NeverBounce/NeverBounceApi-Ruby/badges/gpa.svg" /></a>
</p>

NeverBounceApi-Ruby
===================

This is the official NeverBounce V4 API for Ruby. See also:

* Our full RubyDoc documentation: http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby.
* Our full REST API documentation: https://developers.neverbounce.com/v4.0/.
* RubyGems CLI: https://github.com/NeverBounce/NeverBounceCli-Ruby.

## Installation

In your `Gemfile`, add:

```ruby
gem "neverbounce-api"
```

> For **edge version,** fetch the gem directly:
> ```ruby
> gem "neverbounce-api", git: "https://github.com/NeverBounce/NeverBounceApi-Ruby.git"
> ```

Install bundle:

```sh
$ bundle install
```

In your Ruby code, do a:

```ruby
require "neverbounce"
```

## Usage

To talk to the API, create a `Client` object and call one of its request methods.
For example, let's get account info:

```ruby
client = NeverBounce::API::Client.new(api_key: "secret_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")   # Insert YOUR key here.
resp = client.account_info

if resp.ok?
  puts "Free credits used: #{resp.credits_info.free_credits_used}"
  puts "Free credits remaining: #{resp.credits_info.free_credits_remaining}"
else
  # This is a `Response::ErrorMessage`.
  puts "Error: #{resp.status}: #{resp.message}"
end
```

>The API username and secret key used to authenticate V3 API requests will not work to authenticate V4 API requests. If you are attempting to authenticate your request with the 8 character username or 12-16 character secret key the request will return an auth_failure error. The API key used for the V4 API will look like the following: secret_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx. To create new V4 API credentials please go [here](https://app.neverbounce.com/apps/custom-integration/new).

Now, let's check a single e-mail:

```ruby
resp = client.single_check(email: "support@neverbounce.com")
if resp.ok?
  puts "Result: #{resp.result}"
  puts "Flags: #{resp.flags.join(' ')}"
else
  puts "Error: #{resp.status}: #{resp.message}"
end
```

### Error handling

Our API library raises subclasses of `API::Error` for higher-level errors and subclasses of `StandardError` in all other cases. This wrapper guarantees that you catch all errors from the API library:

```ruby
begin
  client = NeverBounce::API::Client.new(...)
  resp = client.jobs_create(...)
  ...
rescue => e
  # Log the error with full backtrace.
end
```

If you're running a background job, it's generally better to **log the full backtrace** in case you encounter unexpected server behaviour or something like that.

## Client requests

This a is complete list of requests supported by `API::Client`.

### Get account information

```ruby
resp = client.account_info
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#account_info-instance_method), [REST](https://developers.neverbounce.com/v4.0/reference#account-info).

### Check a single address

```ruby
resp = client.single_check(email: "alice@isp.com")
resp = client.single_check(email: "alice@isp.com", address_info: true, credits_info: true, timeout: 3)
```

### Confirm frontend (Javascript Widget) verification

```ruby
resp = client.poe_confirm(email: "alice@isp.com", transaction_id: "NBTRNS-abcdefg123456", confirmation_token: "abcdefg123456", result: "valid")
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#single_check-instance_method), [REST](https://developers.neverbounce.com/v4.0/reference#single-check).

### Create a bulk job

```ruby
resp = client.jobs_create(supplied_input: [["alice@isp.com", "Alice Roberts"], ["bob.smith@gmail.com", "Bob Smith"]])
resp = client.jobs_create(remote_input: "http://isp.com/emails.csv")
resp = client.jobs_create(remote_input: "http://isp.com/emails.csv", filename: "emails.csv", run_sample: true)
resp = client.jobs_create(remote_input: "http://isp.com/emails.csv", filename: "emails.csv", auto_start: true)
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#jobs_create-instance_method), [REST](https://developers.neverbounce.com/v4.0/reference#jobs-create).

### Get bulk job status

```ruby
resp = client.jobs_status(job_id: 123)
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#jobs_status-instance_method), [REST](https://developers.neverbounce.com/v4.0/reference#jobs-status).

### Get bulk job results

```ruby
resp = client.jobs_results(job_id: 123)
resp = client.jobs_results(job_id: 123, page: 1, per_page: 20)    # Grab the first 20.

# Process items:
resp.results.items.each do |item| ...
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#jobs_results-instance_method), [Item](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Response/JobsResults/Item.html), [REST](https://developers.neverbounce.com/v4.0/reference#jobs-results).

### Download bulk job result as CSV

```ruby
resp = client.jobs_download(job_id: 123)

# Parse:
emails = CSV.parse(resp.raw)
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#jobs_download-instance_method), [REST](https://developers.neverbounce.com/v4.0/reference#jobs-download).

### List/search bulk jobs

```ruby
resp = client.jobs_search
resp = client.jobs_search(page: 1, per_page: 20)    # Grab the first 20.

# Process items:
resp.results.each do |item|
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#jobs_search-instance_method), [Result](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Response/JobsSearch/Result.html), [REST](https://developers.neverbounce.com/v4.0/reference#jobs-search).

### Start an existing bulk job

```ruby
resp = client.jobs_start(job_id: 123)
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#jobs_start-instance_method), [REST](https://developers.neverbounce.com/v4.0/reference#jobs-start).

### Parse an existing bulk job

```ruby
resp = client.jobs_parse(job_id: 123)
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#jobs_parse-instance_method), [REST](https://developers.neverbounce.com/v4.0/reference#jobs-parse).

### Delete a bulk job

```ruby
resp = client.jobs_delete(job_id: 123)
```

See also: [method](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Client.html#jobs_delete-instance_method), [REST](https://developers.neverbounce.com/v4.0/reference#jobs-delete).

## Debugging in the console

When you make requests from the console, you'll notice that the responses don't show you any content, i.e. instance variables:

```
irb> resp = client.account_info
=> #<NeverBounce::API::Response::AccountInfo:0x0056245c3e56f8>
irb> resp.inspect
=> "#<NeverBounce::API::Response::AccountInfo:0x0056245c3e56f8>"
```

It happens because by design our response containers **lazy-load their attributes** upon first access. Let's request an attribute:

```
irb> resp.status
=> "success"
irb> resp
=> #<NeverBounce::API::Response::AccountInfo:0x0056245c3e56f8 @status="success">
```

In order to load **all** attributes use method `.touch`, like this:

```
irb> resp.touch
=> #<NeverBounce::API::Response::AccountInfo:0x0056245c3e56f8 @status="success",
@execution_time=98, @credits_info=#<NeverBounce::API::Response::CreditsInfo::Paid:0x0056245c430478
@paid_credits_used=0, @free_credits_used=0, @paid_credits_remaining=1000000,
@free_credits_remaining=973>,@job_counts=#<NeverBounce::API::Response::AccountInfo::JobCounts:0x0056245c430310
@completed=10, @processing=0, @queued=0, @under_review=0>>
```

This is true for all API response containers and sub-containers. See [#touch](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Feature/Oattrs/InstanceMethods.html#touch-instance_method) in the docs.

## Advanced usage

For most regular tasks `Client` is powerful enough. However, if you need more control, you can use [Request](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Request.html), [Session](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Session.html) and [Response](http://rubydoc.info/github/NeverBounce/NeverBounceApi-Ruby/NeverBounce/API/Response/SuccessMessage.html) classes directly. Please refer to the online docs.

For example, our [CLI gem](https://github.com/NeverBounce/NeverBounceCli-Ruby) uses them.

## Command line interface

We've got a gem called [neverbounce-cli](https://github.com/NeverBounce/NeverBounceCli-Ruby) which gives you a set of powerful CLI scripts to use our API.

We recommend to install the CLI to have these tools at hand.

## Compatibility

Minimum Ruby version is 2.0.

## Copyright

NeverBounce API for Ruby is free and is licensed under the MIT License.
Copyright &copy; 2017 NeverBounce.

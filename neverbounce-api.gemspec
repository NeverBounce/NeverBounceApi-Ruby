
require_relative "lib/never_bounce/api/version"

Gem::Specification.new do |s|
  s.name = "neverbounce-api"
  s.summary = "The official NeverBounce API library for Ruby"

  s.authors = ["NeverBounce"]
  s.email = ["support@neverbounce.com"]
  s.homepage = "https://neverbounce.com"
  s.license = "MIT"
  s.version = NeverBounce::API::VERSION

  s.files = `git ls-files`.split("\n")
  s.required_ruby_version = ">= 2.0.0"
  s.require_paths = ["lib"]
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency("httparty", "~> 0.15")
end

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

  ruby_version = Gem::Version.new(RUBY_VERSION)

  if ruby_version >= Gem::Version.new("3.1.0")
    s.add_dependency("bigdecimal", "~> 3.2")
    s.add_dependency("csv", "~> 3.3")
  end

  if ruby_version >= Gem::Version.new("3.4.0")
    s.add_dependency("base64", "~> 0.3.0")
  end

  s.add_development_dependency("redcarpet") # for YARD
  s.add_development_dependency("rspec")
  s.add_development_dependency("simplecov", "~> 0.22")
  s.add_development_dependency("yard")
end

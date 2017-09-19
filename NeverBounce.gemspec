require './libs/NeverBounce'

Gem::Specification.new do |s|
  s.name        = 'NeverBounce'
  s.version     = NeverBounce::VERSION
  s.date        = '2016-02-22'
  s.summary     = "(depreciated) The official NeverBounce V3 API library for Ruby"
  s.description = "The official NeverBounce V3 API library for Ruby. The V3 API has been depreciated, do not use this for new projects. Please use `neverbounce-api` for new applications."
  s.authors     = ["Mike Mollick"]
  s.email       = ['mike@neverbounce.com']
  s.homepage    = 'https://neverbounce.com'
  s.license     = 'MIT'
  s.files       = `git ls-files libs/*`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["libs"]
  s.required_ruby_version     = '>= 1.9.3'

  s.add_dependency('httparty', '~> 0.13')

  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('rake')
end

Gem::Specification.new do |s|
  s.name        = 'NeverBounce'
  s.version     = '0.1.0'
  s.date        = '2016-02-22'
  s.summary     = "The official NeverBounce API library for Ruby"
  s.description = "This offers "
  s.authors     = ["Mike Mollick"]
  s.email       = ['mike@neverbounce.com']
  s.files       = ["NeverBounce.rb", "NeverBounce/Errors.rb", "NeverBounce/Single.rb"]
  s.homepage    = 'https://neverbounce.com'
  s.license       = 'MIT'
  s.required_ruby_version     = '>= 1.9.3'

  s.add_dependency('httparty', '~> 0.13.7')

  s.add_development_dependency('rspec', '~> 3.4.0')
  s.add_development_dependency('rake')
end
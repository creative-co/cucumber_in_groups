Gem::Specification.new do |s|
  s.name        = 'cucumber_in_groups'
  s.version     = '0.0.1'
  s.date        = '2013-03-30'
  s.summary     = "Run first or second half of your cucumber features separately"
  s.description = "Helps dividing cucumber features into groups to run them in parallel"
  s.authors     = ["Vladimir Yartsev"]
  s.email       = 'vovayartsev@gmail.com'
  s.files       = ["lib/cucumber_in_groups.rb"]
  s.homepage    = 'https://github.com/cloudcastle/cucumber_in_groups'

  s.add_runtime_dependency "activesupport", "~> 3.0"

  s.add_development_dependency "cucumber", "~> 1.0"
  s.add_development_dependency 'rake', "~> 10.0"
  s.add_development_dependency 'rspec', "~> 2.13"
end

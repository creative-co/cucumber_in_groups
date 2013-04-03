Gem::Specification.new do |s|
  s.name        = 'cucumber_in_groups'
  s.version     = '0.0.1'
  s.date        = '2013-03-30'
  s.summary     = "Run first or second half of your cucumber features separately"
  s.description = "Helps dividing cucumber features into groups to run them in parallel"
  s.authors     = ["Vladimir Yartsev"]
  s.email       = 'vovayartsev@gmail.com'
  s.files       = ["lib/tasks/cucumber_in_groups.rake", "lib/cucumber_in_groups.rb"]
  s.homepage    = 'https://github.com/cloudcastle/cucumber_in_groups'

  s.add_runtime_dependency "active_support"

  s.add_development_dependency "cucumber", "~> 1.2.3"
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end

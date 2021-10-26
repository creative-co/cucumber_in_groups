Gem::Specification.new do |s|
  s.name        = 'cucumber_in_groups'
  s.version     = '0.0.4'
  s.date        = '2020-09-08'
  s.summary     = "Splits your cucumber features into groups to run them separately"
  s.description = "Add <%= grouped_features %> to your cucumber.yml and get your cucumber features divided into groups. Useful for parallel test running. e.g in Semaphore CI"
  s.authors     = ["Vladimir Yartsev"]
  s.email       = 'vovayartsev@gmail.com'
  s.files       = ["lib/cucumber_in_groups.rb"]
  s.homepage    = 'https://github.com/cloudcastle/cucumber_in_groups'

  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "cucumber"

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end

#$:.unshift(File.dirname(__FILE__) + '/../lib')
#$:.unshift(File.dirname(__FILE__))

# For Travis....
if defined? Encoding
  Encoding.default_external = 'utf-8'
  Encoding.default_internal = 'utf-8'
end

require 'rubygems'
require 'bundler/setup'

require 'cucumber'
$KCODE='u' if Cucumber::RUBY_1_8_7

puts "Loading..."
require 'cucumber_in_groups'


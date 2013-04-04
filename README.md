cucumber_in_groups
==================

Splits your cucumber features into groups to run them separately.
Useful for parallel test running. e.g in Semaphore CI

Usage
=====

In your Gemfile

    gem "cucumber_in_groups", :require => false, :group => [:development, :test]


In the beginning of your cucumber.yml, add this line:

    <% require 'cucumber_in_groups' %>

Then update your profiles cucumber.yml so that Cucumber takes "*.feature" files
from <%= grouped_features %> instead of the default "features" directory:

    <% common = "--tags ~@wip --strict" %>
    # Was:
    # default: <%= common %> features
    # ci: <%= common %> --tags ~@noci features
    default: <%= common %> <%= grouped_features %>
    ci: <%= common %> --tags ~@noci <%= grouped_features %>

Then in your CI script, use GROUP environment variable. Group
numbers are 1-based (e.g. 1of3, 2of3, 3of3)

    RAILS_ENV=test GROUP=1of2 bundle exec rake cucumber


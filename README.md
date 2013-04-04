![CI Status](https://semaphoreapp.com/api/v1/projects/a8069b3299fa4d7cf3f3daa72278cc1c41a559ce/35836/badge.png)

Cucumber_in_groups
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
    
    # default: <%= common %> features
    default: <%= common %> <%= grouped_features %>

    # ci: <%= common %> --tags ~@noci features
    ci: <%= common %> --tags ~@noci <%= grouped_features %>

Then in your CI script, use GROUP environment variable. Group
numbers are 1-based (e.g. 1of3, 2of3, 3of3)

    RAILS_ENV=test GROUP=1of2 bundle exec rake cucumber

Advanced Usage
==============

You can specify custom feature directories by passing relative paths in grouped_features() call. The paths are relative to the project root.

    <%= grouped_features("features", "../common_features", "some/other/features") %>

Pitfalls
========

Make sure you have enough features to divide them into groups. E.g. if you have *only one* "*.feature" file, 
the command below will give you unexpected results:

    RAILS_ENV=test GROUP=2of2 bundle exec rake cucumber

This happens because <%= grouped_features %> expression returns empty string in this case, 
and cucumber may simply run all features instead of none.

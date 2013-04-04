require 'spec_helper'
require 'yaml'

module Cucumber
  module Cli
    describe ProfileLoader, "#grouped_features" do
      def given_cucumber_yml_defined_as(hash_or_string)
        Dir.stub!(:glob).with('{,.config/,config/}cucumber{.yml,.yaml}').and_return(['cucumber.yml'])
        File.stub!(:exist?).and_return(true)
        cucumber_yml = hash_or_string.is_a?(Hash) ? hash_or_string.to_yaml : hash_or_string
        IO.stub!(:read).with('cucumber.yml').and_return(cucumber_yml)
      end

      def loader
        ProfileLoader.new
      end

      it "should run 'features' folder by default when GROUP is not set and no args given" do
        ENV.delete('GROUP')
        given_cucumber_yml_defined_as({'ci' => '--format "ugly" <%= grouped_features %>'})
        loader.args_from('ci').should == ['--format', 'ugly', 'features']
      end

      it "should just join its arguments when GROUP is not set" do
        ENV.delete('GROUP')
        given_cucumber_yml_defined_as({'ci' => '--format "ugly" <%= grouped_features("a", "b") %>'})
        loader.args_from('ci').should == ['--format', 'ugly', 'a', 'b']
      end

      it "should run only features/first.feature when GROUP=1of2 and no args given" do
        ENV['GROUP'] = "1of2"
        ProfileLoader.any_instance.should_receive(:list_features).with(['features']).and_return(["features/first.feature", "features/second.feature"])
        given_cucumber_yml_defined_as({'ci' => '--format "ugly" <%= grouped_features %>'})
        loader.args_from('ci').should == ['--format', 'ugly', 'features/first.feature']
      end

      it "should run only features/second.feature when GROUP=2of2 and 'a, b' args provided " do
        ENV['GROUP'] = "2of2"
        ProfileLoader.any_instance.should_receive(:list_features).with(['a', 'b']).and_return(["a/first.feature", "b/second.feature"])
        given_cucumber_yml_defined_as({'ci' => '<%= grouped_features("a", "b") %>'})
        loader.args_from('ci').should == ['b/second.feature']
      end

      it "should run only features/second.feature when GROUP=2of2 even when files listing is not sorted " do
        ENV['GROUP'] = "2of2"
        ProfileLoader.any_instance.should_receive(:list_features).with(['features']).and_return(["features/second.feature", "features/first.feature"])
        given_cucumber_yml_defined_as({'ci' => '<%= grouped_features %>'})
        loader.args_from('ci').should == ['features/second.feature']
      end

      it "should work for even number of features " do
        ENV['GROUP'] = "2of2"
        ProfileLoader.any_instance.should_receive(:list_features).with(['features']).and_return(["features/second.feature", "features/first.feature", "features/third.feature"])
        given_cucumber_yml_defined_as({'ci' => '<%= grouped_features %>'})
        loader.args_from('ci').should == ['features/third.feature']
      end

      it "should list features using Dir[...]" do
        ENV['GROUP'] = "1of2"
        pl = ProfileLoader.new
        Dir.should_receive(:[]).with("a/**/*.feature").and_return(["a/second.feature", "a/first.feature"])
        Dir.should_receive(:[]).with("b/**/*.feature").and_return(["b/third.feature"])
        pl.list_features(["a", "b"]).should == ["a/second.feature", "a/first.feature", "b/third.feature"]
      end
    end
  end
end
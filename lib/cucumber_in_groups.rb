# We monkey-patch this file
# require 'cucumber/cli/profile_loader'
# Instead of requiring it and using 'class_eval' we just open the class to avoid dependency issues

# provides Array#in_groups
require 'active_support/core_ext/array/grouping'

module Cucumber
  module Cli

    # this class handles cucumber.yml loading - we monkey-patch it
    class ProfileLoader

      def grouped_features(*args)
        # default argument
        args << "features" if args.empty?

        # USAGE: GROUP=1of2 rake cucumber:ci
        # OR:    GROUP=2of2 rake cucumber:ci
        if ENV["GROUP"]
          if ENV["GROUP"] =~ /^(\d+)of(\d+)$/
            group = $1.to_i
            groups_count = $2.to_i
            if group > 0 and group <= groups_count
              # listing content of features folder (or whatever folder requested)
              features = list_features(args).sort
              files_to_test = features.in_groups(groups_count, false)[group-1]

              if ENV['DEBUG']
                STDERR.puts "\n=========== FEATURES GROUP #{group} of #{groups_count} ============="
                STDERR.puts files_to_test.inspect
                STDERR.puts "==============================================="
              end

              # returning files array to cucumber.yml
              files_to_test.join(" ")
            else
              raise "Invalid value of GROUP env variable (#{ENV['GROUP']}). First number should be in 1..#{groups_count} range"
            end
          else
            raise "Invalid value of GROUP env variable (#{ENV['GROUP']}). Expected e.g. GROUP=1of2"
          end
        else
          args.join(" ")
        end
      end

      def list_features(paths)
        paths.flatten.map { |path| Dir["#{path}/**/*.feature"] }.flatten
      end

    end
  end
end
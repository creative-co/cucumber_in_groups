unless ARGV.any? { |a| a =~ /^gems/ } # Don't load anything when running the gems:* tasks

  require 'cucumber/rake/task'
  require 'active_support/core_ext/array/grouping'

  namespace :cucumber do

    Cucumber::Rake::Task.new({:ci => 'db:test:prepare'}, 'Run features that should pass on CI only, optionally divided into groups') do |t|
      t.profile = 'ci'

      # USAGE: GROUP=1of2 rake cucumber:ci
      # OR:    GROUP=2of2 rake cucumber:ci
      if ENV["GROUP"]
        if ENV["GROUP"] =~ /^(\d+)of(\d+)$/
          group = $1.to_i
          groups_count = $2.to_i

          # creating a table of features (1.feature .. 8.feature), like this:
          # |  1  |  2  |  3  |
          # |  4  |  5  |  6  |
          # |  7  |  8  | nil |
          features_table = Dir["features/*.feature"].sort.in_groups_of(groups_count)

          # then taking a particular column from the table
          files_to_test = features_table.map { |row| row[group-1] }.compact

          # some debug info on-screen
          puts "=========== FEATURES GROUP #{group} of #{groups_count} ============="
          puts files_to_test.inspect
          puts "==============================================="

          # this env variable is accessed in cucumber.yml later
          ENV["FEATURES"] = files_to_test.join(" ")
        else
          # invalid usage of GROUP environment variable detected
          raise "USAGE: GROUP=1of2 rake cucumber:ci"
        end
      else
        # GROUP env variable is not set - testing the whole directory's content
        ENV["FEATURES"] = "features"
      end
    end
  end

end

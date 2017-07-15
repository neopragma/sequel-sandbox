Dir.glob('.rake/*.rake').each { |r| import r }

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc 'Reset the database and run specs'
task :clean_and_run_specs do
  Rake::Task["clean"].invoke
  Rake::Task["reset_db"].invoke
  Rake::Task["spec"].invoke
end

task :clean do
  rm ENV['SEQUEL_LOG'] if File.exist?(ENV['SEQUEL_LOG'])
end

task :reset_db do
  ruby "#{ENV['PROJECT_ROOT']}/app/db_init.rb"
end

task :default => :clean_and_run_specs

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
desc 'Default: run specs.'
task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec)

desc 'Generate code coverage'
RSpec::Core::RakeTask.new(:coverage)

require File.expand_path('../config/application', __FILE__) if File.exist?(File.expand_path('../config/application', __FILE__))
Rails.application.load_tasks if defined?(Rails) && Rails.respond_to?(:application) && Rails.application

require 'rake'

namespace :ci do
  desc 'Validate ruby syntax of every tracked .rb file'
  task :syntax do
    files = `git ls-files '*.rb'`.split("\n").reject(&:empty?)
    files.each do |f|
      sh "ruby -c #{f} > /dev/null" do |ok, _|
        raise "ruby syntax error in #{f}" unless ok
      end
    end
    puts "[ok] #{files.size} .rb files parse"
  end

  desc 'Validate every tracked YAML file'
  task :yaml do
    require 'yaml'
    files = `git ls-files '*.yml' '*.yaml'`.split("\n").reject(&:empty?)
    files.each do |f|
      begin
        YAML.load_file(f)
      rescue StandardError => e
        raise "yaml error in #{f}: #{e.message}"
      end
    end
    puts "[ok] #{files.size} YAML files parse"
  end

  desc 'Run rubocop if .rubocop.yml exists'
  task :rubocop do
    if File.exist?('.rubocop.yml')
      sh 'bundle exec rubocop --no-color' do |ok, _|
        raise 'rubocop failed' unless ok
      end
    else
      puts '[skip] no .rubocop.yml in this revision'
    end
  end

  desc 'Run rspec if spec/spec_helper.rb exists'
  task :rspec do
    if File.exist?('spec/spec_helper.rb')
      sh 'bundle exec rspec --no-color' do |ok, _|
        raise 'rspec failed' unless ok
      end
    else
      puts '[skip] no spec/spec_helper.rb in this revision'
    end
  end
end

desc 'Run the full quality gate: syntax + yaml + rubocop + rspec'
task ci: ['ci:syntax', 'ci:yaml', 'ci:rubocop', 'ci:rspec']

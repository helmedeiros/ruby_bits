ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require 'coveralls'
Coveralls.wear!('rails')

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

RSpec.configure do |c|
  c.use_transactional_fixtures = true
  c.infer_spec_type_from_file_location!
  c.filter_rails_from_backtrace!
end

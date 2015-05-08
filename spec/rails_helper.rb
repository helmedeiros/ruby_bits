require 'spec_helper'

require 'capybara/rails'
require 'factory_girl_rails'
require 'database_cleaner'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
  c.include Capybara::DSL, type: :feature

  c.before(:suite) { DatabaseCleaner.clean_with(:truncation) }
  c.around(:each) do |ex|
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.cleaning { ex.run }
  end
end

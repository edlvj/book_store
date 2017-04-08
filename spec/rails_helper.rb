ENV['RAILS_ENV'] ||= 'test'


require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'aasm/rspec'
require 'rectify/rspec'

require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/rspec/matchers'
require 'with_model'

%w(support).each do |folder|
  Dir[Rails.root.join("spec/#{folder}/**/*.rb")].each do |component|
    require component
  end
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
  config.include Rails.application.routes.url_helpers
  config.include Rectify::RSpec::Helpers
  config.include ActionDispatch::TestProcess
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.include Warden::Test::Helpers
  config.extend WithModel

  config.use_transactional_fixtures = true
  
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
    Warden.test_mode!
  end

  config.before(:each) { DatabaseCleaner.start }

  config.after :each do
    DatabaseCleaner.clean
    Warden.test_reset!
  end

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

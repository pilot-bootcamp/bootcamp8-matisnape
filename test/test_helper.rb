ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
require 'capybara/rails'
require 'capybara-webkit'
require 'database_cleaner'
DatabaseCleaner.clean_with :truncation

Dir["./test/helpers/**/*.rb"].sort.each { |f| require f }

class ActiveSupport::TestCase
  fixtures :all

  teardown do
    DatabaseCleaner.clean_with :truncation
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include AbstractController::Translation

  Capybara::Webkit.configure do |config|
    config.block_unknown_urls
  end

  self.use_transactional_fixtures = false

  setup do
    Capybara.current_driver = :webkit
  end

  teardown do
    Capybara.use_default_driver
    DatabaseCleaner.clean_with :truncation
  end
end

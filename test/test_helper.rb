ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara-webkit'
require 'database_cleaner'
DatabaseCleaner.clean_with :truncation

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  Capybara.register_driver :selenium do |app, path|
    profile = Selenium::WebDriver::Firefox::Profile.new
    Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
  end

  self.use_transactional_fixtures = false

  # setup do
  #   Capybara.current_driver = :webkit
  # end

  # teardown do
  #   Capybara.use_default_driver
  #   DatabaseCleaner.clean_with :truncation
  # end
end

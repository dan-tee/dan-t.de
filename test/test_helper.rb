ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest-rails'
require 'minitest/rails/capybara'
require 'minitest/colorize'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def self.prepare
    # Add code that needs to be executed before test suite start
  end
  prepare

  def setup
    # Add code that need to be executed before each test
  end

  def teardown
    # Add code that need to be executed after each test
  end
end

#class Capybara::Rails::TestCase
#  def setup
#    # Code to be executed before each scenario
#  end
#
#  def teardown
#    # Code to be executed after each scenario
#    Capybara.reset_sessions!
#  end
#end

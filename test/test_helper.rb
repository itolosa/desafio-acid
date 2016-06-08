ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'support/action_mailer_helpers'
require 'webmock/minitest'
class ActiveSupport::TestCase
  include ActionMailerHelpers
  
  WebMock.disable_net_connect!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

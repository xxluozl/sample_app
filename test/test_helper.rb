ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  include ApplicationHelper
  # Run tests in parallel with specified workers
  parallelize(workers: 1, with: :threads) #开启并行测试，workers改为1不开启。

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

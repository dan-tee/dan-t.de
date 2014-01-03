if Rails.env.test?
  require 'minitest/rails/capybara'

  # run tests in features on every run too
  MiniTest::Rails::Testing.default_tasks << 'features'
end
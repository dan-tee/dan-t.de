# customizes controller generators
Rails.application.config.generators do |g|
  g.test_framework :mini_test

  g.helper false
  g.assets false
end
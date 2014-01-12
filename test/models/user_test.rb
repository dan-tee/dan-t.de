require 'test_helper'
require_relative '../../../app/controllers/support/user_sessions'

class UserTest < ActiveSupport::TestCase
  include UserSessions

  # this tests for an old bug that took long to find
  test 'user token stays constant' do
    user = User.new
    id_token = SecureRandom.urlsafe_base64
    user.id_token = id_token
    user.save!
    user = User.find_by :id_token, id_token
    assert user.id_token = id_token
  end
end
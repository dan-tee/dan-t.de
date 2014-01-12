require 'test_helper'
require_relative '../../../app/controllers/support/user_sessions'

# this test is an instance of ActionView::TestCase to have cookies available
class UserSessionsTest < ActionView::TestCase
  include UserSessions

  test 'get current user' do
    create_user!
    assert_not_nil get_current_user
  end
end
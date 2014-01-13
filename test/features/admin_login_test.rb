require 'test_helper'

require 'support/session_helper'

class AdminLoginTest < Capybara::Rails::TestCase
  include SessionHelper

  test 'login with wrong password' do
    visit login_path
    fill_in 'Password', with: 'wrong password'
    click_button 'Log in'

    assert_selector 'h1', { text: 'Admin login page' }
    assert_selector '.alert-danger', { text: 'Wrong password' }
  end
end
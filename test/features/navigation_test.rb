require 'test_helper'
require 'support/session_helper'
require_relative '../../app/controllers/authorization'

class NavigationTest < Capybara::Rails::TestCase
  include Authorization, SessionHelper

  test 'home link' do
    visit contact_path
    within('.navbar') do
      click_link 'Daniel Thomas'
    end
    assert_equal 'Dan-T', page.title
  end

  test 'navigation CV link' do
    visit root_path
    within('.navbar') do
      click_link 'CV'
    end
    assert_equal 'CV', page.title
  end

  test 'home page CV link' do
    visit root_path
    within('#linkdiv') do
      click_link 'CV'
    end
    assert_equal 'CV', page.title
  end

  test 'contact link' do
    visit root_path
    within('.navbar') do
      click_link 'Contact'
    end
    assert_equal 'Contact', page.title
  end

  test 'discuss link' do
    visit root_path
    within('.navbar') do
      click_link 'Discuss'
    end
    assert_equal 'Discuss', page.title
  end

  test 'admin link for admins' do
      login!
      visit root_path
      page.assert_selector('li', text: 'Admin', visible: true)
  end

  test 'admin link for non admins' do
    visit root_path
    page.assert_selector('li', text: 'Admin', count: 0)
  end
end

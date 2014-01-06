require 'test_helper'

class NavigationTest < Capybara::Rails::TestCase
  test 'home link' do
    visit contact_path
    within('.navbar') do
      click_link 'Daniel Thomas'
    end
    assert_equal 'Dan-T', page.title
  end

  test 'Navigation CV link' do
    visit root_path
    within('.navbar') do
      click_link 'CV'
    end
    assert_equal 'CV', page.title
  end

  test 'Home page CV link' do
    visit root_path
    within('#linkdiv') do
      click_link 'CV'
    end
    assert_equal 'CV', page.title
  end

  test 'Contact link' do
    visit root_path
    within('.navbar') do
      click_link 'Contact'
    end
    assert_equal 'Contact', page.title
  end

  test 'Discuss link' do
    visit root_path
    within('.navbar') do
      click_link 'Discuss'
    end
    assert_equal 'Discuss', page.title
  end
end

require 'test_helper'
require 'support/session_helper'

class StatisticsTest < Capybara::Rails::TestCase
  include SessionHelper

  test 'page views are contained in statistics' do
    login!
    path_list = [ root_path,
                  cv_path,
                  contact_path,
                  discuss_path,
                  login_path ]
    path_list.each &lambda { |path| visit path }

    visit statistics_page_views_path

    page.assert_selector 'h1', { text: 'Page Views' }
    path_list.each do |path|
      page.assert_selector 'td', { text: path }
    end
  end
end
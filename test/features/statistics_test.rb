require 'test_helper'
require 'support/session_helper'
require 'support/table_helper'

class StatisticsTest < Capybara::Rails::TestCase
  include SessionHelper
  include TableHelper

  test 'page views are contained in statistics' do
    login!
    path_list = [ root_path,
                  cv_path,
                  contact_path,
                  discuss_path,
                  statistics_aggregated_per_user_path ]
    path_list.each &lambda { |path| visit path }

    visit statistics_page_views_path

    page.assert_selector 'h1', { text: 'Page Views' }
    path_list.each do |path|
      page.assert_selector 'td', { text: path }
    end
  end

  test 'page views are contained in aggregated statistics' do
    login!
    path_list = [ root_path,
                  contact_path,
                  private_messages_path,
                  statistics_page_views_path ]

    (1..4).each {|i| i.times { visit path_list[i-1] } }

    visit statistics_aggregated_per_user_path

    page.assert_selector 'h1', { text: 'Aggregated Page Views' }
    page.assert_selector :xpath, column_content_xpath('Home', 1)
    page.assert_selector :xpath, column_content_xpath('Contact', 2)
    # admin pages. plus one for visiting private_messages_path after login
    # and another visit for showing the statistics aggregated page
    page.assert_selector :xpath, column_content_xpath('Admin Pages', 9)
  end
end
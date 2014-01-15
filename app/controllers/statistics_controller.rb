class StatisticsController < ApplicationController
  before_action :redirect_non_admin

  def page_views
    @page_views = PageView.all.page(params[:page]).per(100)
  end

  def aggregated_per_user
    per_user_and_page_views = PageView.select('user_id, page, sum(1) as sum').
                                      group('user_id, page')
    users_and_pages_hash = reorder_page_views(per_user_and_page_views)
    user_and_pages_array = add_sums users_and_pages_hash
    paginatable = Kaminari.paginate_array(user_and_pages_array)
    @users_and_pages_hash = paginatable.page(params[:page]).per(100)
  end

  private

    # the list of views by user and page gets transformed to a hash containing
    # a hash per user, that contains the views per page.
    def reorder_page_views page_views_table
      users_and_pages_hash = {}
      admin_pages = %w{ /logout
                        /private_messages
                        /statistics/page_views
                        /statistics/aggregated_per_user }

      page_views_table.each do |views|
        users_and_pages_hash[views.user_id] = users_and_pages_hash[views.user_id] || {}
        page_views = users_and_pages_hash[views.user_id]
        raise 'there should be no double entries' if page_views[views.page]
        page_views[views.page] = views.sum

        page_views['admin_pages'] ||= 0
        page_views['admin_pages'] += views.sum if admin_pages.include? views.page
        page_views['all'] ||= 0
        page_views['all'] += views.sum
      end
      users_and_pages_hash
    end

    def add_sums views_hash
      all = []
      all[0] = 'all'
      all[1] = calculate_sums views_hash
      array = []
      array.append all
      array.concat views_hash.to_a
      array
    end

    def calculate_sums views_hash
      sums = {}
      views_hash.each do |user, per_page_views|
        per_page_views.each do |page, views|
          sums[page] ||= 0
          sums[page] += views
        end
      end
      sums
    end
end

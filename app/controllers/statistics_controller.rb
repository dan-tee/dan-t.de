class StatisticsController < ApplicationController
  def page_views
    @page_views = PageView.all.page(params[:page]).per(50)
  end

  def aggregated_per_user
    per_user_views = PageView.select('id, url, sum(1)').group('id, url')
  end
end

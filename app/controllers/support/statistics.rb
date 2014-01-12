module Statistics
  include UserSessions

  def capture_statistics!
    if cookies[:user_token]
      user = get_current_user
    else
      user = create_user!
      user
    end

    page_view = user.page_views.new
    page_view.url = request.url
    page_view.format = request.format
    page_view.method = request.method
    page_view.save!
  end
end
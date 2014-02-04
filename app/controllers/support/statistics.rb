module Statistics
  include UserSessions

  def capture_statistics!
    if cookies[:user_token]
      user = get_current_user
      # hack for charlotte
      if user.id == 57
          flash.now[:success] = 'Greetings not so secret admirer. A pleasure to see you again.'
      end
    else
      user = create_user!
      user
    end

    page_view = user.page_views.new
    # first group matches double slash till next slash and is optinal
    # second group matched everything from the first single slash
    matches = %r'(//[^/]*)?(/.*)'i.match request.url
    page_view.page = matches[2]
    page_view.format = request.format.to_s
    page_view.method = request.method
    page_view.save!
  end
end
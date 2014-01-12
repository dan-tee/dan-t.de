module UserSessions
  def create_user!
    user = User.new
    user.id_token = SecureRandom.urlsafe_base64
    cookies.permanent[:user_token] = user.id_token
    user.save!
    user
  end

  def get_current_user
      User.find_by! id_token: cookies[:user_token]
  end
end
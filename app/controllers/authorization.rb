module Authorization

  def redirect_non_admin
    unless admin?
      flash[:danger] = 'Redirected, because you are not admin'
      redirect_to root_path
    end
  end

  def redirect_admin
    if admin?
      flash[:danger] =  'Redirected, because you are already admin'
      redirect_to root_path
    end
  end

  # all state like @admin is wiped for every request
  # that is why we have to get the current user from the db.
  def admin?
    return true unless @admin.nil?

    admin_token = cookies[:admin_token]
    return false if admin_token.blank?

    @admin ||= Admin.find_by_admin_token(admin_token)
    !@admin.nil?
  end

  def make_admin!
    admin = Admin.new
    admin.ip = request.remote_ip if defined? request.remote_ip
    cookies[:admin_token] = { value: admin.admin_token,
                              expires: 1.week.from_now }
    admin.save
    @admin = admin
  end

  def delete_admin
    @admin = nil
    admin_token = cookies[:admin_token]
    admin = Admin.find_by(:admin_token, admin_token)
    admin.destroy unless admin.nil?
    cookies.delete(:admin_token)
  end
end
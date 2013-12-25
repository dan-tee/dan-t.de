module AdminsHelper
  # all state like @admin is wiped for every request
  # that is why we have to get the current user from the db.
  def admin?
    return true unless @admin.nil?

    admin_token = cookies[:admin_token]
    return false if admin_token.blank?

    @admin ||= Admin.find_by_admin_token(admin_token)
    !@admin.nil?
  end

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
end

# The hash of the admin password is stored in a file
# To become admin, a client has to pass the right password
# and gets an admin cookie in return. This cookie is used
# to grant admin rights until explicit logout.
module Authorization
  @@password_path = File.join(Rails.root, 'config', '.admin_password')

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

  def check_password(password, check_bruteforce = true)
    return false if check_bruteforce && is_bruteforce_attack
    return false unless password_file_exists?

    admin_hash = File.read(@@password_path).strip
    correct = (admin_hash == password_hash(password))

    @alarm_level = 0 if correct
    correct
  end

  def set_password!(password)
    return if File.exist? @@password_path
    password_file = File.new @@password_path, 'w'
    password_file.puts(password_hash(password))
    password_file.close
  end

  def password_file_exists?
    File.exist? @@password_path
  end

  private

    def is_bruteforce_attack
      if last_attempt_too_recent
        @alarm_level += 1
        @last_attempt = Time.now
        return true
      else
        @last_attempt = Time.now
        @alarm_level = 0
        return false
      end
    end

    def last_attempt_too_recent
      return false unless @alarm_level
      wait_time = (2 ** @alarm_level).seconds
      @last_attempt + wait_time > Time.now
    end

    def password_hash(password)
      Digest::SHA1.hexdigest(password + DanTDe::Application.config.secret_key_base)
    end
end
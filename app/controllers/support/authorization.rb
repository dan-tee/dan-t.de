require_relative 'user_sessions'

# The hash of the admin password is stored in a file
# To become admin, a client has to pass the right password
# and then a admin flag is set for the user corresponding
# to the id_token in the clients cookies.
module Authorization
  include UserSessions

  PASSWORD_PATH = File.join(Rails.root, 'config', '.admin_password')

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

  # all state like @is_admin is wiped for every request
  # that is why we have to get the current user from the db.
  def admin?
    return true if @is_admin

    user = get_current_user
    @is_admin = user.is_admin
  end

  def make_admin!
    user = get_current_user
    user.admin_login_ip = request.remote_ip if defined? request.remote_ip
    user.is_admin = true
    user.save
    @is_admin = true
  end

  def delete_admin
    @is_admin = false
    user = get_current_user
    user.admin_login_ip = nil
    user.is_admin = false
    user.save
  end

  def check_password(password, check_bruteforce = true)
    return false if check_bruteforce && is_bruteforce_attack
    return false unless password_file_exists?

    admin_hash = File.read(PASSWORD_PATH).strip
    correct = (admin_hash == password_hash(password))

    @alarm_level = 0 if correct
    correct
  end

  def set_password!(password)
    return if File.exist? PASSWORD_PATH
    password_file = File.new PASSWORD_PATH, 'w'
    password_file.puts(password_hash(password))
    password_file.close
  end

  def password_file_exists?
    File.exist? PASSWORD_PATH
  end

  private

    def is_bruteforce_attack
      if last_attempt_too_recent
        @alarm_level += 1
        @last_attempt = Time.now
        true
      else
        @last_attempt = Time.now
        @alarm_level = 0
        false
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
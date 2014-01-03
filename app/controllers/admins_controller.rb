class AdminsController < ApplicationController
  before_action :redirect_non_admin,    only: :destroy
  before_action :redirect_admin,        only: :new, create:

  def new
  end

  def create
    if check_password(params['Password'])
      make_admin!
      redirect_to private_messages_path
    else
      flash[:danger] = 'Wrong password'
      redirect_to login_path
    end
  end

  def destroy
    delete_admin
    flash[:success] = 'Logout successful'
    redirect_to root_path
  end

  private

    def check_password(password)
      path = File.join(Rails.root, 'config', '.admin_password')
      admin_hash = File.read(path).strip
      given_hash = Digest::SHA1.hexdigest(password + DanTDe::Application.config.secret_key_base)
      admin_hash == given_hash
    end
end

# an admin in the sense of this controller is a client that
# has successfully registered as admin

class AdminSessionsController < ApplicationController
  before_action :redirect_non_admin,    only: :destroy
  before_action :redirect_admin,        only: :new, create:

  def new
  end

  def create
    if check_password(params['Password'])
      make_admin!
      flash[:success] = 'You are admin now'
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
end

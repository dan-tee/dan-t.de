class PasswordsController < ApplicationController
  def new
    if password_file_exists?
      flash[:danger] = 'Password is already set'
      redirect_to root_path
    end
  end

  def create
    if password_file_exists?
      flash[:danger] = 'Password is already set'
      redirect_to root_path
    elsif params['Password'] == params['Confirmation']
      set_password!(params['Password'])
      make_admin!
      flash[:success] = 'Password set. You are admin now.'
      redirect_to root_path
    else
      flash[:danger] = "Password doesn't match confirmation"
      redirect_to new_password_path
    end
  end
end

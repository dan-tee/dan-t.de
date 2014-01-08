class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Authorization

  before_action :set_is_admin!

  private

    def set_is_admin!
      @is_admin = admin?
    end

end

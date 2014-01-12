require_relative 'support/authorization'
require_relative 'support/statistics'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Authorization
  include Statistics

  before_action :capture_statistics!
  before_action :set_is_admin!

  def wipe_cookies!
    cookies.each do |cookie|
      cookie.delete
    end
  end

  private

    def set_is_admin!
      @is_admin = admin?
    end
end

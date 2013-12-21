class MainPagesController < ApplicationController
  def home
  end

  def discuss
  end

  def contact
    @message = PrivateMessage.new
  end

  def about
  end
end

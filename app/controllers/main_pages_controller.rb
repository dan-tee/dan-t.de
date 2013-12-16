class MainPagesController < ApplicationController
  def home
    render 'main_pages/home', layout: 'wide'
  end

  def discuss
  end

  def contact
    @message = PrivateMessage.new
  end

  def about
  end
end

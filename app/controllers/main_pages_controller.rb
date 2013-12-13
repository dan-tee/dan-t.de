class MainPagesController < ApplicationController
  def home
    render 'main_pages/home', layout: 'wide'
  end

  def contact
  end

  def about
  end
end

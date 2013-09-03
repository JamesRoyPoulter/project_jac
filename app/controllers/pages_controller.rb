class PagesController < ApplicationController
  def home
    redirect_to checkins_path if current_user
  end
end

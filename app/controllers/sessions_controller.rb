class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    # binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to checkins_path, :notice => "Welcome back, #{user.email}"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id]=nil
    redirect_to root_path, notice: 'logged out!'
  end

end

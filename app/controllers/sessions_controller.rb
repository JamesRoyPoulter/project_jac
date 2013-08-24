class SessionsController < ApplicationController
  before_filter :authenticate, only: [:destroy]

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Welcome back, #{user.email}"
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

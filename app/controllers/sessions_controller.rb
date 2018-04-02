class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password]) && verify_recaptcha(model: user)
      log_in(user)
      flash[:success] = "Welcome back, #{user.username}!"
      redirect_to root_path
    else 
      flash[:danger] = 'Invalid email/password combination!'
      # render partial: 'new', layout: false
    end
  end

  def destroy
    log_out 
    redirect_to root_path 
  end
end

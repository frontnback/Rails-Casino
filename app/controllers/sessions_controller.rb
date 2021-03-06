class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password]) 
      # if user.email_confirmed
        log_in(user)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "Welcome back, #{user.username}!"
        redirect_to root_path
      # else 
      #   flash.now[:error] = 'Please activate your account by following the instructions sent to your email account on file.'
      #   render 'new'
      # end
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

# && verify_recaptcha(model: user)
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(params[:username])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      # log_in @user 
      flash[:success] = "Thanks for registering, #{@user.username}!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def leaderboard
    @users = User.order(:balance).reverse.select { |user| user.balance != nil }
    @current = true
  end

  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      @user.validate_email
      flash[:success] = 'Success!'
      redirect_to root_path
    else
      flash[:error] = 'Sorry, user does not exist'
    end
  end

  private 
    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end
end


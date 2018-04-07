class SearchController < ApplicationController
  def index
    @users = User.where("username like ?", "%#{params[:username]}%")
            .select{ |u| u.username.downcase.start_with?(params[:username]) }
    @users = nil if @users.empty?
  end
end

class FriendRequestsController < ApplicationController
  # before_action :set_friend_request, except: [:index, :create]

  def create
    requestee = User.find(params[:friend_id].to_i)
    @friend_request = FriendRequest.new(sender_id: current_user.id, requested_id: requestee.id)
    byebug
    if @friend_request.save
      render :show, status: :created, location: @friend_request
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def index
    @incoming = FriendRequest.where(requested_id: current_user)
  end

  # private

  # def set_friend_request
  #   @friend_request = FriendRequest.find(params[:id])
  # end
end

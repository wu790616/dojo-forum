class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:update, :destroy]

  def create
    friend = User.find(params[:friend_id])
    puts friend
    @friend_request = current_user.friend_requests.new(friend: friend)
    @friend_request.save
    redirect_back(fallback_location: root_path)
  end

  def update
    @friend_request.accept
    #redirect_back(fallback_location: root_path)
  end

  def destroy
    @friend_request.destroy
  end

  private

  def set_friend_request
    user = User.find(params[:user_id])
    @friend_request = user.friend_requests.where(friend_id: current_user).first
  end
end

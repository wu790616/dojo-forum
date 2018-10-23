class FriendRequestsController < ApplicationController

  def create
    friend = User.find(params[:friend_id])
    puts friend
    @frend_request = current_user.friend_requests.new(friend: friend)
    @frend_request.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:user_id])
    @frend_request = user.friend_requests.where(friend_id: current_user).first
    @frend_request.destroy
    redirect_back(fallback_location: root_path)
  end

end

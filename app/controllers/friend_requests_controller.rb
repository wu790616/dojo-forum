class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:update, :destroy]

  def create
    friend = User.find(params[:friend_id])
    puts friend
    @frend_request = current_user.friend_requests.new(friend: friend)
    @frend_request.save
    redirect_back(fallback_location: root_path)
  end

  private

  def set_friend_request
    @frend_request = FriendRequest.find(params[:id])
  end
end

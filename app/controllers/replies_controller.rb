class RepliesController < ApplicationController
  before_action :set_reply, only: [:edit, :update, :destroy]
  before_action :reply_permission, only: [:create]

  def create
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
    if params[:commit] == "Save"
      unless @reply.update_attributes(reply_params)
        flash[:alert] = @reply.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path) 
      end 
    end
  end

  def destroy
    @reply.destroy
  end

  private

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end

  def reply_permission
    @post = Post.find(params[:post_id])
    if @post.permission == "myself" && @post.user != current_user
      flash[:alert] = "只有作者可以留言"
      redirect_to root_path
    elsif @post.permission == "friend" && @post.user.friends.exclude?(current_user) && @post.user != current_user
      flash[:alert] = "只有作者好友可以留言"
      redirect_to root_path
    end
  end
end

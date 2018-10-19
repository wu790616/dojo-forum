class RepliesController < ApplicationController
  before_action :set_reply, only: [:edit, :update]

  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  def update
    if params[:commit] == "Save"
      @reply.update_attributes(reply_params)
    end
  end

  private

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end

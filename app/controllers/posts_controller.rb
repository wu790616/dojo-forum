class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :draft)
  end  
end

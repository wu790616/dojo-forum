class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
    redirect_to post_path(@post)
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :draft, {category_ids:[]}, :image, :permission)
  end

  def set_post
    @post = Post.find(params[:id])
  end  
end

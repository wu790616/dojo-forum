class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:show, :edit, :update]

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.draft = false if publishing?
    @post.draft = true unless publishing?
    @post.save
    redirect_to post_path(@post)
  end

  def show
    @reply = Reply.new
    @replies = @post.replies
  end

  def edit
    if @post.user != current_user
      flash[:alert] = "只有作者可以編輯"
      redirect_to post_path(@post)
    end
  end

  def update
    @post.draft = false if publishing?
    @post.draft = true unless publishing?
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

  def publishing?
    if params[:commit] == "Submit"
      return true
    end
    return false
  end 
end

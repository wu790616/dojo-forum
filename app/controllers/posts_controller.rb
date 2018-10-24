class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :collect, :uncollect, :modify, :modified]
  before_action :view_permission, only: [:show]

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.draft = false if publishing?
    @post.draft = true unless publishing?
    @post.edit_time = Time.current
    @post.save
    redirect_to post_path(@post)
  end

  def show
    @reply = Reply.new
    @pagy, @replies = pagy(@post.replies)
    if @post.user != current_user
      @post.views_count += 1
      @post.save      
    end
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
    @post.edit_time = Time.current
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Post has removes"
      redirect_to root_path
    end
  end

  def collect
    @post.collects.create!(user: current_user)
  end

  def uncollect
    collects = Collect.where(post: @post, user: current_user)
    collects.destroy_all
  end

  def modify
    if @post.user != current_user
      flash[:alert] = "只有作者可以編輯"
      redirect_to post_path(@post)
    end
  end

  def modified
    if params[:commit] == "Save"
      @post.edit_time = Time.current
      @post.update(post_params)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :draft, {category_ids:[]}, :image, :permission, :edit_time)
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

  def view_permission
    if @post.permission == "friend"
      unless @post.user == current_user || @post.user.friends.include?(current_user)
        flash[:alert] = "只有朋友可以觀看"
        redirect_back(fallback_location: root_path)
      end
    elsif @post.permission == "myself" || @post.draft == true
      unless @post.user == current_user
        flash[:alert] = "只有作者可以觀看"
        redirect_back(fallback_location: root_path)        
      end
    end
  end
end

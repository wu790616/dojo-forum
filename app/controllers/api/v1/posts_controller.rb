class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :view_permission, only: [:show]

  def index
    @posts = Post.open
    render json: {
      data: @posts
    }
  end

  def show
    render json: {
      data: @post
    }
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.edit_time = Time.current
    if @post.save
      sleep 1
      render json: {
        message: "Post created successfully!",
        id: @post.id
      }
    else
      render json: {
        errors: @post.errors
      }
    end      
  end

  def update
    if @post.user == current_user
      @post.edit_time = Time.current
      if @post.update!(post_params)
        render json: {
          message: "Post updated successfully!",
          id: @post.id
        }
      else
        render json: {
          errors: @post.errors
        }
      end      
    else
      render json: {
        message: "You don't have permission.",
        status: 405
      }
    end
  end

  def destroy
    if @post.user == current_user || current_user.role == "admin"
      @post.destroy
      render json: {
        message: "Post delete successfully!"
      }
    else
      render json: {
        message: "You don't have permission.",
        status: 405
      }
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find this post.",
        status: 404
      }
    end
  end

  def post_params
    params.permit(:title, :content, :draft, {category_ids:[]}, :image, :permission)
  end

  def view_permission
    if @post.permission == "friend"
      render json: {
        message: "只有朋友可以觀看"
      }
    elsif @post.permission == "myself" || @post.draft == true
      render json: {
        message: "只有作者可以觀看"
      }
    end
  end
end

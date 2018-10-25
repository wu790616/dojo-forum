class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show]

  def index
    @posts = Post.open
    render json: {
      data: @posts
    }
  end

  def show
    if !@post
      render json: {
        message: "Can't find this post.",
        status: 404
      }
    else
      render json: {
        data: @post
      }
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.edit_time = Time.current
    if @post.save
      render json: {
        message: "Post created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end      
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.permit(:title, :content, :draft, {category_ids:[]}, :image, :permission)
  end
end

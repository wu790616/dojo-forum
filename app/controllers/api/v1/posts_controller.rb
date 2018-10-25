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

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end

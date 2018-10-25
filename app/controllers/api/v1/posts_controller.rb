class Api::V1::PostsController < ApiController
  def index
    @posts = Post.open
    render json: @posts
  end
end

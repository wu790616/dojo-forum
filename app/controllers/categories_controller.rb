class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @categories = Category.all
    @posts_grid = initialize_grid(Post.published)
  end

  def feeds
    @users_count = User.all.size
    @posts_count = Post.all.size
    @replies_count = Reply.all.size
    @top10_posts = Post.published.order(replies_count: :desc).limit(10)
    @top10_users = User.all.order(replies_count: :desc).limit(10)
  end

  def show
    @category = Category.find(params[:id])
    @posts_grid = initialize_grid(@category.posts.published)
    @categories = Category.all
  end
end

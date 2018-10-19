class CategoriesController < ApplicationController
  def index
    @posts = Post.all
  end

  def feeds
    @users_count = User.all.size
    @posts_count = Post.all.size
    @replies_count = Reply.all.size
    @top10_posts = Post.published.order(replies_count: :desc).limit(10)
    @top10_users = User.all.order(replies_count: :desc).limit(10)
  end
end

class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @categories = Category.all
    @posts_grid = initialize_grid(list_selector(Post.published), order: 'posts.id', order_direction: 'asc')
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
    @posts_grid = initialize_grid(list_selector(@category.posts.published), order: 'posts.id', order_direction: 'asc')
    @categories = Category.all
  end

  private

  def list_selector(list)
    if current_user && current_user.friends
      # 登入使用者，回傳權限為all和自己已發佈的所有post和朋友權限設為friend的post 
      return (list.open).or(author_post(list)).or(list.for_friend.where(:user => current_user.friends))
    elsif current_user
      # 登入使用者，但沒有朋友，回傳權限為all和自己已發佈的所有post
      return (list.open).or(author_post(list))
    else
      # 未登入使用者，回傳權限為all的post
      return list.open
    end
  end

  def author_post(list)
    return list.where(user: current_user)
  end
end

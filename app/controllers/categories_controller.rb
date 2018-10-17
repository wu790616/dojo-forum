class CategoriesController < ApplicationController
  def index
    @posts = Post.all
  end
end

class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin
  before_action :set_category, only: [:destroy, :edit, :update]

  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end
    @users = User.all
  end

  def destroy
    unless @category.destroy
      flash[:alert] = @category.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end    
  end

  def create
    @category = Category.new(category_params)
    unless @category.save
      flash[:alert] = @category.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end   
  end

  def edit
  end

  def update
    unless @category.update_attributes(category_params)
      flash[:alert] = @category.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

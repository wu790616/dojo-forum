class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin
  before_action :set_category, only: [:destroy]

  def index
    @categories = Category.all
  end

  def destroy
    unless @category.destroy
      flash[:alert] = @category.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path) 
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end

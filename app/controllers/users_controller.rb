class UsersController < ApplicationController
  before_action :set_user

  def show
    @myposts = @user.posts.published
    @mydrafts = @user.posts.draft
    @mycomments = @user.replies
    @mycollects = @user.collected_posts
  end

  def edit
    if @user != current_user
      flash[:alert] = "只有本人可以編輯"
      redirect_to user_path(@user)
    end
  end

  def update 
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :action => :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end

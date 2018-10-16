class UsersController < ApplicationController
  before_action :set_user

  def show  
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
      flash.now[:alert] = @user.errors.full_messages
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

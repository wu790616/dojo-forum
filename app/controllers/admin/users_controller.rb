class Admin::UsersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_user

  def edit
  end

  def update
    @user.update_attributes(user_params)
    flash[:notice] = "Update successfully"
    redirect_to request.referer + "#user-list"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role)
  end
end

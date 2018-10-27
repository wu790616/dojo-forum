class ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!
    if params[:auth_token].present?
      # 比對User model的authentication_token，找到某個特定的User物件
      user = User.find_by_authentication_token(params[:auth_token])
      # sign_in 是 Devise 的方法
      sign_in(user, store: false) if user
    end
  end

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
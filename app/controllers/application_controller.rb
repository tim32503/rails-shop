# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # def authenticate_user!
  #   render(json: { success: false, message: '請先登入會員！' }, status: 401) if params[:token].blank?

  #   @current_user = User.find_by(auth_token: params[:token])
  # end

  private

  def current_cart
    current_user.cart
  end
end

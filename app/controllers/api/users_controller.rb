# frozen_string_literal: true

class Api::UsersController < ApplicationController
  # 註冊
  def create
    @user = User.create!(sign_up_params)

    render(json: { success: true, data: @user.to_json }, status: 201)
  end

  # 登入
  def sign_in
    @user = User.find_by(email: params[:user][:email], encrypted_password: Digest::MD5.hexdigest(params[:user][:password]))

    if @user.present?
      render(json: { success: true, data: @user.auth_token }, status: 200)
    else
      render(json: { success: false, message: '您輸入的帳號密碼有誤，請重新進行登入！' }, status: 401)
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :name)
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Users', type: :request) do
  describe '註冊會員' do
    before(:each) do
      user_params = { email: 'timhsueh@curihaosity.xyz', password: 'Abc12345', name: 'Tim Hsueh' }
      post '/api/users/sign_up', params: { user: user_params }

      @response = JSON.parse(response.body)
    end

    it { expect(response).to(have_http_status(201)) }
  end

  describe '登入會員，並取得驗證用 Token' do
    before(:each) do
      @user = create(:user, password: '12345')
      post '/api/users/sign_in', params: { user: { email: @user.email, password: '12345' } }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['data']).to(eq(@user.auth_token)) }
    it { expect(response).to(have_http_status(200)) }
  end
end

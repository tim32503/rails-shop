# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Carts', type: :request) do
  let!(:user) { create(:user) }

  describe '顯示購物車內項目清單' do
    before(:each) do
      cart = user.create_cart
      products = create_list(:product, 2)

      4.times { cart.add_item(products.first) }
      2.times { cart.add_item(products.second) }

      get '/api/carts', params: { token: user.auth_token }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['success']).to(be(true)) }
    it { expect(@response['data'].size).to(eq(2)) }
    it { expect(response).to(have_http_status(200)) }
  end

  describe '清空購物車' do
    before(:each) do
      @cart = user.create_cart
      products = create_list(:product, 2)

      4.times { @cart.add_item(products.first) }
      2.times { @cart.add_item(products.second) }

      delete '/api/carts', params: { token: user.auth_token }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['success']).to(be(true)) }
    it { expect(user.reload.cart.empty?).to(be(true)) }
    it { expect(response).to(have_http_status(200)) }
  end

  describe '購物車結帳' do
    before(:each) do
      @cart = user.create_cart
      products = create_list(:product, 2)

      4.times { @cart.add_item(products.first) }
      2.times { @cart.add_item(products.second) }

      post '/api/carts/checkout', params: { token: user.auth_token }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['success']).to(be(true)) }
    it { expect(user.reload.cart.empty?).to(be(true)) }
    it { expect(user.orders.first.total_price).to(eq(@cart.total_price)) }
    it { expect(response).to(have_http_status(200)) }
  end
end

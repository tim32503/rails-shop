# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Products', type: :request) do
  let!(:user) { create(:user) }

  describe '顯示商品列表' do
    before(:each) do
      @products = create_list(:product, 10)
      get '/api/products', params: { token: user.auth_token }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['success']).to(eq(true)) }
    it { expect(@response['data'].size).to(eq(10)) }
    it { expect(response).to(have_http_status(200)) }
  end

  describe '查詢特定商品' do
    before(:each) do
      @product = create(:product)
      get "/api/products/#{@product.id}", params: { token: user.auth_token }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['success']).to(eq(true)) }
    it { expect(@response['data']).to(eq(@product.as_json.except('is_available', 'created_at', 'updated_at'))) }
    it { expect(response).to(have_http_status(200)) }
  end

  describe '上架商品' do
    before(:each) do
      @product = build(:product)
      product_params = {
        name: @product.name,
        price: @product.price,
        inventory: @product.inventory,
        is_available: @product.is_available
      }
      post '/api/products', params: { token: user.auth_token, product: product_params }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['success']).to(eq(true)) }
    it { expect(@response['data'].except('id', 'created_at', 'updated_at')).to(eq(@product.as_json.except('id', 'created_at', 'updated_at'))) }
    it { expect(response).to(have_http_status(201)) }
  end

  describe '更新商品' do
    before(:each) do
      @product = create(:product)
      put "/api/products/#{@product.id}", params: { token: user.auth_token, product: { name: "#{@product.name}_new" } }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['success']).to(eq(true)) }
    it { expect(@response['data']['name']).to(eq("#{@product.name}_new")) }
    it { expect(response).to(have_http_status(200)) }
  end

  describe '下架商品' do
    before(:each) do
      @product = create(:product)
      delete "/api/products/#{@product.id}", params: { token: user.auth_token }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['success']).to(eq(true)) }
    it { expect(Product.available.size).to(eq(0)) }
    it { expect(response).to(have_http_status(200)) }
  end

  describe '購買特定商品' do
    before(:each) do
      @product = create(:product)
      post "/api/products/#{@product.id}/buy", params: { token: user.auth_token, quantity: 2 }

      @response = JSON.parse(response.body)
    end

    it { expect(@response['success']).to(be(true)) }
    it { expect(user.cart.empty?).to(be(false)) }
    it { expect(response).to(have_http_status(201)) }
  end
end

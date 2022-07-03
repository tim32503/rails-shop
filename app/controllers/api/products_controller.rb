# frozen_string_literal: true

class Api::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: %i[show update destroy buy]

  def index; end

  def show; end

  def create
    @product = Product.create!(new_product_params)

    render(json: { success: true, data: @product }, status: 201)
  rescue StandardError
    render(json: { success: false, message: '商品建立失敗！' }, status: 400)
  end

  def update
    @product.update!(product_params)
    render(json: { success: true, data: @product }, status: 200)
  rescue StandardError
    render(json: { success: false, message: '商品更新失敗！' }, status: 400)
  end

  def destroy
    @product.update!(is_available: false)
    render(json: { success: true, data: @product }, status: 200)
  rescue StandardError
    render(json: { success: false, message: '商品下架失敗！' }, status: 400)
  end

  def buy
    cart =
      if @current_user.cart.blank?
        @current_user.create_cart
      else
        @current_user.cart
      end

    cart.add_item(@product, params[:quantity])
    render(json: { success: true, data: cart.cart_items }, status: 201)
  rescue StandardError
    render(json: { success: false, message: '商品購買失敗！' }, status: 400)
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id])
  end

  def new_product_params
    params.require(:product).permit(:name, :price, :inventory, :is_available)
  end

  def product_params
    params.require(:product).permit(:name, :price, :inventory)
  end
end

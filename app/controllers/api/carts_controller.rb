# frozen_string_literal: true

class Api::CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_cart, only: %i[destroy checkout]

  def index; end

  def destroy
    @cart.cart_items.destroy_all

    if @cart.empty?
      render(json: { success: true, data: @cart.cart_items }, status: 200)
    else
      render(json: { success: false, message: '購物車清空失敗！' }, status: 400)
    end
  end

  def checkout
    order = @cart.checkout

    render(json: { success: true, data: order }, status: 200)
  rescue StandardError
    render(json: { success: false, message: '購物車結帳失敗！' }, status: 400)
  end

  private

  def find_cart
    @cart = @current_user&.cart
  end
end

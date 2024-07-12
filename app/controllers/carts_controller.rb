class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart_items = current_cart.cart_items.includes(:product)
  end

  def checkout
    @order = current_cart.checkout

    redirect_to root_path, notice: '訂單建立成功！'
  end
end

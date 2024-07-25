class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart_items = current_cart.cart_items.includes(:product)

    @service = NewebpayService.new(user: current_user, return_url: root_url)
    @service.encrypt
  end

  def checkout
    @order = current_cart.checkout

    redirect_to root_path, notice: '訂單建立成功！'
  end

  def newebpay_callback; end
end

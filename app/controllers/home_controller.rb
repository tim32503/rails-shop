class HomeController < ApplicationController
  def index
    @products = Product.available

    return unless user_signed_in?

    @cart = current_cart || current_user.create_cart
    @cart_item_count = current_cart.cart_items.count || 0
  end
end

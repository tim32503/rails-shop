class ProductsController < ApplicationController
  def purchase
    @product = Product.find(params[:id])
    @cart = current_cart || current_user.create_cart

    @cart.add_item(@product)

    redirect_to root_path
  end
end

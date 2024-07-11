class HomeController < ApplicationController
  def index
    @products = Product.available
  end
end

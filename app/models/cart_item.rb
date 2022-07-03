# frozen_string_literal: true

# 購物車內容
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  before_save :calculate_item_total

  def increment(quantity = 1)
    update!(quantity: self.quantity += quantity)
  end

  private

  def calculate_item_total
    product = Product.find_by(id: product_id)
    self.total = self.quantity * product.price
  end
end

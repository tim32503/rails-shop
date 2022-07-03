# frozen_string_literal: true

# 購物車內容
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def increment(quantity = 1)
    self.quantity += quantity
  end
end

# frozen_string_literal: true

# 購物車
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  def add_item(product, quantity = 1)
    available_product = Product.find_by(id: product.id, is_available: true)
    found_item = cart_items.includes(:product).find_by(products: { id: available_product.id })

    if found_item
      found_item.increment(quantity)
    else
      cart_items.create!(product_id: available_product.id, quantity: quantity)
    end
  end

  def empty?
    cart_items.blank?
  end
end

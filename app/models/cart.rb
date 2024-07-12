# frozen_string_literal: true

# 購物車
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_item(product, quantity = 1)
    available_product = Product.available.find_by(id: product.id)
    found_item = cart_items.includes(:product).find_by(products: { id: available_product.id })

    if found_item
      found_item.increment(quantity)
    else
      cart_items.create!(product_id: available_product.id, quantity: quantity)
    end

    calculate_cart_total
  end

  def empty?
    cart_items.blank?
  end

  def checkout
    # 依照購物車資訊建立訂單主要資訊
    order = user.orders.create!(
      status: 'paid',
      total_price: total_price,
      subtotal: subtotal,
      discount: discount
    )

    cart_items.each do |cart_item|
      order.order_items.create!(
        product_id: cart_item.product_id,
        quantity: cart_item.quantity,
        original_price: cart_item.product.price,
        subtotal: cart_item.quantity * cart_item.product.price,
        discount: 0
      )

      cart_item.product.update!(inventory: cart_item.product.inventory - cart_item.quantity)
    end

    destroy!

    order
  end

  private

  def calculate_cart_total
    update!(subtotal: cart_items.sum(:total), discount: 0, total_price: cart_items.sum(:total))
  end
end

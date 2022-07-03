# frozen_string_literal: true

cart_items = @current_user&.cart&.cart_items

json.success(true)

if cart_items.present?
  json.data(cart_items) do |cart_item|
    json.call(cart_item, :total, :quantity)
    json.name(cart_item.product.name)
  end
else
  json.data([])
end

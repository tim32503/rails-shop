# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    order { nil }
    product { nil }
    quantity { 1 }
    original_price { '9.99' }
    subtotal { '9.99' }
    discount { '9.99' }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user { nil }
    status { 'MyString' }
    total_price { '9.99' }
    subtotal { '9.99' }
    discount { '9.99' }
  end
end

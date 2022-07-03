# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Book.title }
    price  { Faker::Number.between(from: 100.0, to: 1000.0) }
    inventory { 99 }
    is_available { true }
  end
end

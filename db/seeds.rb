# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# 使用 Faker 產生產品假資料
50.times do
  Product.create(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 50..500),
    inventory: Faker::Number.between(from: 1, to: 100),
    is_available: Faker::Boolean.boolean
  )
end

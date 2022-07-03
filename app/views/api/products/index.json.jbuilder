# frozen_string_literal: true

products = Product.available

json.success(true)
json.data(products) do |product|
  json.call(product, :id, :name, :price, :inventory)
end

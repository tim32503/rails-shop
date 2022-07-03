# frozen_string_literal: true

json.success(true)
json.data do
  json.call(@product, :id, :name, :price, :inventory)
end

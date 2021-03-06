# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :order_items
  has_many :orders, through: :order_items

  scope :available, -> { where(is_available: true) }
end

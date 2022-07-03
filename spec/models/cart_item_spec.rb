# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let!(:user) { create(:user) }

  it '每個 Cart Item 都可以計算它自己的金額（小計）' do
    p1 = create(:product, price: 80.0)
    p2 = create(:product, price: 200.0)

    cart = user.create_cart
    3.times { cart.add_item(p1) }
    4.times { cart.add_item(p2) }
    2.times { cart.add_item(p1) }

    expect(cart.cart_items.first.total.to_i).to(be(400))
    expect(cart.cart_items.second.total.to_i).to(be(800))
  end
end

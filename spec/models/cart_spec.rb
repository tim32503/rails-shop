# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  let!(:user) { create(:user) }

  before(:each) do
    @cart = user.create_cart
  end

  describe '購物車基本功能' do
    it '可以把商品加入到購物車' do
      products = create_list(:product, 2)

      4.times { @cart.add_item(products.first) }
      2.times { @cart.add_item(products.second) }

      cart_items = @cart.cart_items

      expect(@cart.empty?).to(be(false))
      expect(cart_items.first.product_id).to(be(products.first.id))
      expect(cart_items.second.product_id).to(be(products.second.id))
      expect(cart_items.first.product).to(be_a(Product))
    end

    it '如果加入同種類商品到購物車裡，購買項目不會增加，但商品的數量會改變' do
      products = create_list(:product, 3)

      3.times { @cart.add_item(products.first) }
      5.times { @cart.add_item(products.second) }
      2.times { @cart.add_item(products.third) }

      cart_items = @cart.cart_items

      expect(cart_items.size).to(be(3))
      expect(cart_items.first.quantity).to(be(3))
      expect(cart_items.second.quantity).to(be(5))
    end

    it '可以計算整台購物車的總消費金額' do
      p1 = create(:product, price: 80.0)
      p2 = create(:product, price: 200.0)

      3.times do
        @cart.add_item(p1)
        @cart.add_item(p2)
      end

      expect(@cart.total_price.to_i).to(be(840))
    end
  end

  describe '購物車進階功能' do
    it '可以將購物車內容進行結帳，並成立訂單' do
      p1 = create(:product, price: 80.0)
      p2 = create(:product, price: 200.0)

      3.times do
        @cart.add_item(p1)
        @cart.add_item(p2)
      end

      order = @cart.checkout
      @cart.destroy!

      user.reload

      expect(order.total_price.to_i).to(be(840))
      expect(user.cart.blank?).to(be(true))
    end
  end
end

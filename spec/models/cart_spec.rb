# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  let!(:user) { create(:user) }

  describe '購物車基本功能' do
    before(:each) do
      @cart = user.create_cart
    end

    it '可以把商品加入到購物車' do
      product = create(:product)
      @cart.add_item(product, 1)
      expect(@cart.empty?).to(be(false))
    end

    it '如果加了相同種類的商品到購物車裡，購買項目並不會增加，但商品的數量會改變' do
      products = create_list(:product, 3)

      @cart.add_item(products.first, 3)
      @cart.add_item(products.second, 5)
      @cart.add_item(products.third, 2)

      cart_items = @cart.cart_items

      expect(cart_items.size).to(be(3))
      expect(cart_items.first.quantity).to(be(3))
      expect(cart_items.second.quantity).to(be(5))
    end

    it '商品可以放到購物車裡，也可以再拿出來' do
      products = create_list(:product, 2)

      4.times { @cart.add_item(products.first) }
      2.times { @cart.add_item(products.second) }

      cart_items = @cart.cart_items

      expect(cart_items.first.product_id).to(be(products.first.id))
      expect(cart_items.second.product_id).to(be(products.second.id))
      expect(cart_items.first.product).to(be_a(Product))
    end

    it '可以計算整台購物車的總消費金額'
    it '特別活動可能可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百）'
  end

  describe '購物車進階功能' do
    it '可以將購物車內容轉換成 Hash，存到 Session 裡'
    it '可以把 Session 的內容（Hash 格式），還原成購物車的內容'
    it '可以將購物車內容進行結帳，並成立訂單'
  end
end

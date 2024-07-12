class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart_items = current_cart.cart_items.includes(:product)
    newebpay_info
  end

  def checkout
    @order = current_cart.checkout

    redirect_to root_path, notice: '訂單建立成功！'
  end

  def newebpay_callback
  end

  private

  def newebpay_info
    # 生成請求字串
    query = {
      MerchantID: Rails.application.credentials.dig(:newebpay, :merchant_id),
      RespondType: 'JSON', # 回傳格式
      TimeStamp: Time.now.to_i,
      Version: 2.0, # 串接版本
      MerchantOrderNo: Time.now.to_formatted_s(:number), # 商店訂單編號
      Amt: current_cart.total_price.to_i || 0, # 訂單金額
      ItemDesc: items_description,
      NotifyURL: newebpay_callback_cart_url # 付款通知網址
    }.to_query

    # 將請求字串進行 AES 加密
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    cipher.key = Rails.application.credentials.dig(:newebpay, :hash_key)
    cipher.iv = Rails.application.credentials.dig(:newebpay, :hash_iv)
    @encrypted_data = cipher.update(query) + cipher.final
    @encrypted_data = @encrypted_data.unpack1('H*').upcase!

    # 將加密字串產生檢查碼
    encrypted_text = [
      "HashKey=#{Rails.application.credentials.dig(:newebpay, :hash_key)}",
      @encrypted_data,
      "HashIV=#{Rails.application.credentials.dig(:newebpay, :hash_iv)}"
    ].join('&')

    # 將加密字串使用 SHA256 壓碼並轉為大寫
    @hash_text = Digest::SHA256.hexdigest(encrypted_text).upcase
  end

  def items_description
    current_cart.cart_items.map do |item|
      "#{item.product.name} x #{item.quantity}"
    end.join(' / ')
  end
end

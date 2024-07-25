# frozen_string_literal: true

class NewebpayService
  attr_reader :api_url, :merchant_id, :encrypted_string, :check_code, :version

  def initialize(user:, return_url: nil, notify_url: nil)
    # 使用者資訊
    @user = user

    # Newebpay 商店資訊
    @merchant_id = Rails.application.credentials.dig(:newebpay, :merchant_id)
    @hash_key = Rails.application.credentials.dig(:newebpay, :hash_key)
    @hash_iv = Rails.application.credentials.dig(:newebpay, :hash_iv)

    # Newebpay API 資訊
    @version = 2.0
    @api_url = 'https://ccore.newebpay.com/MPG/mpg_gateway'
    @return_url = return_url
    @notify_url = notify_url
  end

  def encrypt
    generate_query_string && encrypt_query_string && generate_check_code
  end

  private

  def current_cart
    current_user = User.includes(cart: %i[cart_items products]).find(@user.id)
    current_user.cart
  end

  def items_description
    current_cart.cart_items.map do |item|
      "#{item.product.name} x #{item.quantity}"
    end.join(' / ')
  end

  # 生成請求字串
  def generate_query_string
    @query_string =
      {
        MerchantID: @merchant_id,
        RespondType: 'JSON',
        TimeStamp: Time.now.to_i,
        Version: @version,
        MerchantOrderNo: Time.now.to_formatted_s(:number), # TODO: 改用參數待入商店訂單編號
        Amt: current_cart.total_price.to_i || 0,
        ItemDesc: items_description,
        ReturnURL: @return_url,
        NotifyURL: @notify_url
      }.to_query

    true
  rescue StandardError
    false
  end

  # 將請求字串進行 AES 加密
  def encrypt_query_string
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    cipher.key = @hash_key
    cipher.iv = @hash_iv

    encrypted_data = cipher.update(@query_string) + cipher.final
    @encrypted_string = encrypted_data.unpack1('H*').upcase!

    true
  rescue StandardError
    false
  end

  # 將加密字串產生檢查碼
  def generate_check_code
    hash_string = ["HashKey=#{@hash_key}", @encrypted_string, "HashIV=#{@hash_iv}"].join('&')

    # 將加密字串使用 SHA256 壓碼並轉為大寫，即可得到檢查碼
    @check_code = Digest::SHA256.hexdigest(hash_string).upcase

    true
  rescue StandardError
    false
  end
end

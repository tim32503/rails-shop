# frozen_string_literal: true

# 使用者
class User < ApplicationRecord
  attr_accessor :password

  has_one :cart
  has_many :orders

  before_create :encrypt_password
  before_create :genarate_auth_token

  private

  def encrypt_password
    self.encrypted_password = Digest::MD5.hexdigest(password)
  end

  def genarate_auth_token
    self.auth_token = SecureRandom.base58(50)
  end
end

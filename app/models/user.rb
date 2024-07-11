# frozen_string_literal: true

# 使用者
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  before_create :genarate_auth_token

  private

  def genarate_auth_token
    self.auth_token = SecureRandom.base58(50)
  end
end

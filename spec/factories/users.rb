# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    faker_user = Faker::Internet.user('name', 'email', 'password')

    name { faker_user[:name] }
    email  { faker_user[:email] }
    password { faker_user[:password] }
  end
end

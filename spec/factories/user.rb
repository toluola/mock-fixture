FactoryBot.define do
  factory :user do
    email { "toluola7@gmail.com" }
    password { "test123" }
    role { "admin" }
  end
end
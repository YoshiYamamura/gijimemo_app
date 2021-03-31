FactoryBot.define do
  factory :user do
    nickname              { Faker::Internet.username }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) + 'a1' }
    password_confirmation { password }
  end
end

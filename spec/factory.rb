FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
  end

  factory :task do
    name 'default task content'
    description 'this is description'
  end

end
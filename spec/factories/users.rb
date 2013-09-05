FactoryGirl.define do
  sequence(:email) { |n| "sduser_#{n}@n.com" }

  factory :user do
    email
    name 'Luke Skywalker'
    password 'meowmeow'
    password_confirmation 'meowmeow'
  end

end

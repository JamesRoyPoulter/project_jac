FactoryGirl.define do

  factory :user do
    email 'luke@skywalker.com'
    name 'Luke Skywalker'
    password 'tatooine'
    password_confirmation 'tatooine'
  end

end
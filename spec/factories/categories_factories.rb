FactoryGirl.define do

  factory :category do
    trait :with_user do
      user
    end
    name 'Love'
  end

end
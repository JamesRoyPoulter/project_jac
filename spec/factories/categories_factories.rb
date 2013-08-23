FactoryGirl.define do

  factory :category do
    # user
    trait :with_user do
      user
    end
    name 'Love'
  end

end
FactoryGirl.define do

  factory :category do
    association :user
    name 'Love'
  end

end
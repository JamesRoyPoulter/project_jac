FactoryGirl.define do
  factory :categories_checkin do
    association :category
    association :checkin
  end
end

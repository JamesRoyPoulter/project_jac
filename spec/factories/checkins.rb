FactoryGirl.define do

  factory :checkin do
    association :user
    latitude '51.4841'
    longitude '-0.00205'
    title 'Checkin title'
  end

end

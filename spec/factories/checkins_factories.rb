FactoryGirl.define do

  factory :checkin do
    category
    latitude '51.4841'
    longitude '-0.00205'
    title 'Checkin title'
    after(:build) do |checkin|
        checkin.user = checkin.category.user
    end
  end

end

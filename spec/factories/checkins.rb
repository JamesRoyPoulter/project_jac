FactoryGirl.define do

  factory :checkin do
    latitude '51.4841'
    longitude '-0.00205'
    title 'Checkin title'
    user
    before(:create) do |c|
      c.categories << FactoryGirl.create(:category)
    end
  end

end

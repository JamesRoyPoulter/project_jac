FactoryGirl.define do

  factory :checkin do
    user
    category
    # assets_attributes
    address '9 Backhill Lane, PO57 C0D'
    latitude '51.4841'
    longitude '-0.00205'
    title 'Checkin title'
  end

end

FactoryGirl.define do

  factory :asset do
    association :checkin
    words 'lots of words'
    media File.open(File.join(Rails.root,'/app/assets/images/tiny_image.png'))

    after(:build) do |asset|
      asset.user = asset.checkin.user
      asset.category = asset.checkin.category
    end
  end

end

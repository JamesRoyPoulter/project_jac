FactoryGirl.define do

  factory :asset do
    trait :with_user do
      user
    end
    # association :user
    association :category
    association :checkin
    words 'lots of words'
    media File.open(File.join(Rails.root,'/app/assets/images/tiny_image.png'))

    after(:build) do |asset|
      asset.user = asset.checkin.user
    end

  end

end

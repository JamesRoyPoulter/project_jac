FactoryGirl.define do

  factory :asset do
    trait :with_user do
      user
    end
    category
    checkin
    words 'lots of words'
    media File.open(File.join(Rails.root,'/app/assets/images/tiny_image.png'))

  end

end

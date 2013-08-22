FactoryGirl.define do

  factory :asset do
    association :user
    association :category
    association :checkin
    words 'lots of words'
    media File.open(File.join(Rails.root,'/app/assets/images/tiny_image.png'))

  end

end
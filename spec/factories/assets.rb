FactoryGirl.define do

  factory :asset do
    association :checkin
    user_id 1
    category_id 1
    words 'lots of words'
    media File.open(File.join(Rails.root,'/app/assets/images/tiny_image.png'))

    # after(:build) do |asset|
    #   asset.user_id = asset.checkin.user.id
    #   asset.category_id = asset.checkin.category.id
    # end
  end

end

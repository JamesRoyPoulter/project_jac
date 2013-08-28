FactoryGirl.define do

  factory :asset do
    association :checkin
    words 'lots of words'
    media Rack::Test::UploadedFile.new(File.open(File.join(Rails.root,'/app/assets/images/tiny_image.png')))
    after(:build) do |asset|
      asset.user_id = asset.checkin.user.id
    end
  end

end

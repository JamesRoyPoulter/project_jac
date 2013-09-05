FactoryGirl.define do

  factory :image do
    user
    checkin
    media Rack::Test::UploadedFile.new(File.open(File.join(Rails.root,'/app/assets/images/Ehxe_logo.png')))
  end

end

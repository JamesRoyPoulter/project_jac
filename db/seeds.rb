Checkin.destroy_all
User.destroy_all

def rando(arr)
  arr[rand(arr.count)]
end

@user = User.create email: 'cj@cj.com', name: 'CJ Ponti', password: 'meowmeow', password_confirmation: 'meowmeow'

@categories = {
  love: Category.create(name: 'Love', user_id: @user.id),
  food: Category.create(name: 'Food'), user_id: @user.id),
  art: Category.create(name: 'Art'), user_id: @user.id)
}
@words = ['love','food','art']
@file_types = ['text','image']

@index = 0
20.times do
  @coords = [Faker::Address.latitude, Faker::Address.longitude]

  category = rando(@words)
  file_type = rando(@file_types)

  if file_type == 'image'
    media = case category
      when 'love' then File.open(File.join(Rails.root, '/app/assets/images/love.jpg'))
      when 'food' then File.open(File.join(Rails.root, '/app/assets/images/food.jpg'))
      when 'art' then File.open(File.join(Rails.root, '/app/assets/images/street_art.jpg'))
    end
    words = ''
  else
    media = ''
    words = 'Meow Meow Meow'
  end

  @checkin = Checkin.create latitude: @coords[0], longitude: @coords[1], title: "checkin_#{@index+1}", user_id: @user.id,
    category_id: @categories[category].id
  @asset = Asset.create media: media, file_type: file_type, words: words, checkin_id: @checkin.id, user_id: @user.id,
    category_id: @categories[category].id
end
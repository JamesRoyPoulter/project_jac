Checkin.destroy_all
Category.destroy_all
Asset.destroy_all
User.destroy_all

def rando(arr)
  arr[rand(arr.count)]
end

@user = User.new(email: 'cj@cj.com', name: 'CJ Ponti', password: 'meowmeow', password_confirmation: 'meowmeow')
if @user.save
  puts 'User saved...'
  @love = Category.new(name: 'Love', user_id: @user.id)
  @food = Category.new(name: 'Food', user_id: @user.id)
  @art = Category.new(name: 'Art', user_id: @user.id)
  if @love.save && @food.save && @art.save
    puts 'Categories saved...'
    @words = ['love','food','art']
    @file_types = ['text','image']
    @index = 0
    20.times do
      @latitudes = (514433..515432).to_a
      @longitudes = (187..24948).to_a
      @coords = [rando(@latitudes)/10000.00,-(rando(@longitudes)/100000.00)]
      category = rando(@words)
      file_type = rando(@file_types)
      if file_type == 'image'
        case category
          when 'love'
            @category = @love
            media = File.open(File.join(Rails.root, '/app/assets/images/love.jpg'))
          when 'food'
            @category = @food
            media = File.open(File.join(Rails.root, '/app/assets/images/food.jpg'))
          when 'art'
            @category = @art
            media = File.open(File.join(Rails.root, '/app/assets/images/street_art.jpg'))
        end
        words = ''
      else
        @category = case category
          when 'love' then @love
          when 'food' then @food
          when 'art' then @art        
        end
        media = ''
        words = 'Meow Meow Meow'
      end
      @checkin = Checkin.create(latitude: @coords[0], longitude: @coords[1], title: "checkin_#{@index+1}", user_id: @user.id, category_id: @category.id)
      @asset = Asset.create(media: media, file_type: file_type, words: words, checkin_id: @checkin.id, user_id: @user.id,category_id: @category.id)
    end
  end
end
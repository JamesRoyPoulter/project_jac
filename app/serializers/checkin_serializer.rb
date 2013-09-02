class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :title, :description, :user_id, :address,
             :created_at, :categories, :video, :audio, :image


  def video
    Video.where(checkin_id: self.id)
  end

  def audio
    Audio.where(checkin_id: self.id)
  end

  def image
    Image.where(checkin_id: self.id)
  end

end

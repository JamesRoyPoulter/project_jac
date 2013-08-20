class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :text, :image, :audio, :video, :user_id, :category_id, :address
end

class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :user_id, :category_id, :address
end

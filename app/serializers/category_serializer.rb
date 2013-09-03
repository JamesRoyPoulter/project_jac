class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :color
  has_many :checkins, serializer: CheckinSerializer
end

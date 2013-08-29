class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id
  has_many :checkins, serializer: CheckinSerializer
end

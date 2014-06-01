class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :picture, :user_id

  has_many :checkins, serializer: CheckinSerializer
end

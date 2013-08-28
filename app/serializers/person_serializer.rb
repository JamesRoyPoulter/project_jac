class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :picture, :user_id, :checkins
end

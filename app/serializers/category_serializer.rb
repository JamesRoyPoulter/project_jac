class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :checkins
end

class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :title, :user_id, :address, :created_at, :categories,
             :seperated_assets

  def seperated_assets
    Checkin.find(self.id).assets.group_by(&:file_type)
  end

end

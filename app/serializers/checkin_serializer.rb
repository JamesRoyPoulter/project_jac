class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :title, :user_id, :address, :assets,
             :created_at, :categories

  # def asset
  #   results = []
  #   Asset.where(checkin_id: self.object.id).each do |asset|
  #     results << (asset.file_type == 'text' ? asset.words : asset.media)
  #   end
  #   results
  # end

end

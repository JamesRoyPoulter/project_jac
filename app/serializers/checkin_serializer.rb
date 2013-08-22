class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :user_id, :category, :address, :asset, :created_at

  def category
    self.object.category.name
  end
  
  def asset
    results = []
    Asset.where(checkin_id: self.object.id).each do |asset|
      results << (asset.file_type == 'text' ? asset.words : asset.media)
    end
    results
  end

end

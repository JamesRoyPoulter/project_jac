class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :title, :user_id, :address, :created_at, :categories,
             :seperated_assets

  def seperated_assets
    results = {text:[],image:[], video:[],audio:[]}
    Checkin.find(self.id).assets.each do |asset|
      results[asset.file_type.to_sym] << asset
    end
    results
  end

end

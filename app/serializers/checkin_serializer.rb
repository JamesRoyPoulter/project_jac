class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :title, :user_id, :address, :created_at, :categories, :assets,
                  :image_assets, :video_assets, :audio_assets, :words_assets, :seperated_assets


  def seperated_assets
    results = {text:[],image:[], video:[],audio:[]}
    self.assets.each do |asset|
      results[asset.file_type.to_sym] << asset
    end
    results
  end

  def words_assets
    self.assets.where(file_type: 'text').first
  end

  def image_assets
    self.assets.where(file_type: 'image').first
  end

  def video_assets
    self.assets.where(file_type: 'video').first
  end

  def audio_assets
    self.assets.where(file_type: 'audio').first
  end

end

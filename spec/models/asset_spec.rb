require 'spec_helper'

describe Asset do
  before :each do
    @asset = FactoryGirl.create :asset, :with_user
  end
  describe '#new' do

    it 'should instantiate a new Asset' do
      expect(@asset).to be_an_instance_of Asset
    end

    it 'should have an assigned user' do
      expect(@asset.user.name).to eq 'Luke Skywalker'
    end

    it 'should have an assigned category' do
      expect(@asset.category.name).to eq 'Love'
    end

    it 'should have an assigned checkin' do
      expect(@asset.checkin.title).to eq 'Checkin title'
    end

  end

end
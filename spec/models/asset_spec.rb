require 'spec_helper'

describe Image do

  let(:image) { FactoryGirl.create :image }

  describe '#new' do

    it 'should instantiate a new Image' do
      expect(image).to be_an_instance_of Image
    end

    it 'should have an assigned user' do
      expect(image.user.name).to eq 'Luke Skywalker'
    end

    it 'should have an assigned checkin' do
      expect(image.checkin.title).to eq 'Checkin title'
    end

  end

end

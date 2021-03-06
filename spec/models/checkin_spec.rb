require 'spec_helper'

describe Checkin do
  describe '#new' do
    let(:checkin) { FactoryGirl.create :checkin }

    it 'should instantiate a new Asset' do
      expect(checkin).to be_an_instance_of Checkin
    end

    it 'should have an assigned user' do
      expect(checkin.user.name).to eq 'Luke Skywalker'
    end

    it 'should assign an address' do
      expect(checkin.address).to eq '46 Old Woolwich Road, London, Greater London SE10 9NY, UK'
    end

    it 'should assign a latitude' do
      expect(checkin.latitude).to eq 51.4841
    end

    it 'should assign a longitude' do
      expect(checkin.longitude).to eq -0.00205
    end

    it 'should assign a title' do
      expect(checkin.title).to eq 'Checkin title'
    end

    it 'should have a category' do
      expect(checkin.categories.first.name).to eq 'Love'
    end
  end
end

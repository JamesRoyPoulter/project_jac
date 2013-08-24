require 'spec_helper'

describe Category do
  describe '#new' do
    before :each do
      @category = FactoryGirl.create :category
    end
    it 'should instantiate a new Category' do
      expect(@category).to be_an_instance_of Category
    end

    it 'should have an assigned user' do
      expect(@category.user.name).to eq 'Luke Skywalker'
    end

    it 'should assign a name' do
      expect(@category.name).to eq 'Love'
    end

    # it 'should format name' do
    #   @category1 = FactoryGirl.build :category, name: 'LOVE'
    #   expect(@category1.name).to eq 'Love'
    # end
  end
end
require 'spec_helper'

describe Category do
  before :each do
    @category = FactoryGirl.create :category
  end
  describe '#new' do
    it 'should instantiate a new Category' do
      expect(@category).to be_an_instance_of Category
    end
    it 'should have an assigned user' do
      expect(@category.user.name).to eq 'Luke Skywalker'
    end
  end

end
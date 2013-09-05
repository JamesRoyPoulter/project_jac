require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  describe '#new' do
    it 'should create a new instance of User' do
      expect(user).to be_an_instance_of(User)
    end
    it "should set the user's name" do
      expect(user.name).to eq('Luke Skywalker')
    end
  end

end

require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.create :user
  end
  describe '#new' do
    it 'should instantiate a new User' do
      expect(@user).to be_an_instance_of User
    end
     it 'should assign email' do
        expect(@user.email).to eql('luke@skywalker.com')
     end

     it 'should assign name' do
      expect(@user.name).to eql('Luke Skywalker')
    end
  end
end
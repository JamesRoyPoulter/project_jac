require 'spec_helper'

describe CheckinsController do

  let(:user) { FactoryGirl.create(:user) }

  before (:each) do
    sign_in user
  end

  let(:valid_attributes) {
    {
      title: "MyString",
      description:'blah blah',
      category_ids: ['1'],
      latitude: '51.4841',
      longitude: '-0.00205',
      user_id: user.id
    }
  }

  describe "GET index" do
    it "assigns current_user's checkins to @checkins" do
      checkin = FactoryGirl.create :checkin, user: user
      get :index, {}
      assigns(:checkins).should eq(user.checkins)
    end
  end

  describe "GET show" do
    it "assigns the requested checkin as @checkin" do
      checkin = FactoryGirl.create :checkin
      get :show, {:id => checkin.to_param}
      assigns(:checkin).should eq(checkin)
    end
  end

  describe "GET new" do
    it "assigns a new checkin as @checkin" do
      get :new, {}
      assigns(:checkin).should be_a_new(Checkin)
    end
  end

  describe "GET edit" do
    it "assigns the requested checkin as @checkin" do
      checkin = FactoryGirl.create :checkin
      get :edit, {:id => checkin.to_param}
      assigns(:checkin).should eq(checkin)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Checkin" do
        expect {
          post :create, {:checkin => valid_attributes }
        }.to change(Checkin, :count).by(1)
      end

      it "assigns a newly created checkin as @checkin" do
        post :create, {:checkin => valid_attributes }
        assigns(:checkin).should be_a(Checkin)
        assigns(:checkin).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved checkin as @checkin" do
        # Trigger the behavior that occurs when invalid params are submitted
        Checkin.any_instance.stub(:save).and_return(false)
        post :create, {:checkin => { "title" => "invalid value" }}
        assigns(:checkin).should be_a_new(Checkin)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Checkin.any_instance.stub(:save).and_return(false)
        post :create, {:checkin => { "title" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested checkin" do
        checkin = Checkin.create! valid_attributes
        put :update, {:id => checkin.to_param, :checkin => { "title" => "MyString" }}
      end

      it "assigns the requested checkin as @checkin" do
        checkin = Checkin.create! valid_attributes
        put :update, {:id => checkin.to_param, :checkin => valid_attributes}
        assigns(:checkin).should eq(checkin)
      end

      it "redirects to the checkin" do
        checkin = Checkin.create! valid_attributes
        put :update, {:id => checkin.to_param, :checkin => valid_attributes}
        response.should redirect_to(checkin)
      end
    end

    describe "with invalid params" do
      it "assigns the checkin as @checkin" do
        checkin = Checkin.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Checkin.any_instance.stub(:save).and_return(false)
        put :update, {:id => checkin.to_param, :checkin => { "title" => "blah blah" }}
        assigns(:checkin).should eq(checkin)
      end

      it "re-renders the 'edit' template" do
        checkin = Checkin.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Checkin.any_instance.stub(:save).and_return(false)
        put :update, {:id => checkin.to_param, :checkin => { "title" => "blah blah" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested checkin" do
      checkin = Checkin.create! valid_attributes
      expect {
        delete :destroy, {:id => checkin.to_param}
      }.to change(Checkin, :count).by(-1)
    end

    it "redirects to the checkins list" do
      checkin = Checkin.create! valid_attributes
      delete :destroy, {:id => checkin.to_param}
      response.should redirect_to(checkins_url)
    end
  end

end

require 'spec_helper'

describe CategoriesController do

  let(:user) { FactoryGirl.create(:user) }

  before (:each) do
    sign_in user
  end

  let(:valid_attributes) { { name: "MyString", color:'aqua', user_id: user.id } }

  describe "GET index" do
    it "assigns current_user's categories to @categories" do
      category = FactoryGirl.create :category, user: user
      get :index, {}
      assigns(:categories).should eq(user.categories)
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category = FactoryGirl.create :category
      get :show, {:id => category.to_param}
      assigns(:category).should eq(category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {}
      assigns(:category).should be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      category = FactoryGirl.create :category
      get :edit, {:id => category.to_param}
      assigns(:category).should eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:category => FactoryGirl.attributes_for(:category) }
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => FactoryGirl.attributes_for(:category)}
        assigns(:category).should be_a(Category)
        assigns(:category).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => { "name" => "invalid value" }}
        assigns(:category).should be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested category" do
        category = Category.create! valid_attributes
        # Assuming there are no other categories in the database, this
        # specifies that the Category created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Category.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => category.to_param, :category => { "name" => "MyString" }}
      end

      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}
        assigns(:category).should eq(category)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}
        response.should redirect_to(categories_url)
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        category = Category.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => { "name" => "invalid value" }}
        assigns(:category).should eq(category)
      end

      it "re-renders the 'edit' template" do
        category = Category.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Category.create! valid_attributes
      delete :destroy, {:id => category.to_param}
      response.should redirect_to(categories_url)
    end
  end

end

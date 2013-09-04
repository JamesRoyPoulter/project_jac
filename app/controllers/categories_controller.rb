class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = Category.where(user_id: current_user.id)

    respond_to do |format|
      format.html
      format.json { render json: @categories }
    end
  end

  def show
    @category = Category.find(params[:id])
    @checkins = @category.checkins
    respond_to do |format|
      format.html
      format.json { render json: @category }
    end
  end

  def search
    if params[:name_startsWith]
      @categories = Category.where(
        'name ilike :name AND user_id=:id',
        name: "%#{params[:name_startsWith]}%",
        id: current_user.id
      )
      render json: @categories, root: false
    else
      @category = Category.where(
        'name ilike :name AND user_id=:id',
        name: "%#{params[:name]}%",
        id: current_user.id).first
      render json: @category.checkins, root: false
    end
  end

  def new
    @category = Category.new

    respond_to do |format|
      format.html
      format.json { render json: @category }
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.checkins.empty?
      @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url }
        format.json { head :no_content }
      end
    else
      redirect_to categories_url, notice: 'This category has checkins...'
    end
  end

  private
   def category_params
    params[:category][:user_id] = current_user.id
    params[:category]
   end
end

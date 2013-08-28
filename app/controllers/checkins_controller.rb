class CheckinsController < ApplicationController
  before_filter :authenticate
  protect_from_forgery

  def index
    @checkins = Checkin.belonging_to current_user

    respond_to do |format|
      format.html
      format.json { render json: @checkins.reverse }
    end
  end

  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @checkin }
    end
  end

  # Person.where(user_id: current_user.id)

  def search
    @category = params[:category]
    @query = "%#{params[:query]}%"
    @sql = 'name ilike :query AND user_id=:id'
    @id = current_user.id
    @checkins = case @category
      when 'people' then Person.where(@sql, query: @query, id:@id).first.checkins
      when 'category' then Category.where(@sql, query: @query, id:@id).first.checkins
      when 'location' then Checkin.near @query
    end
    render json: @checkins
  end

  def new
    @checkin = Checkin.new
  end

  def past
    @checkin = Checkin.new
  end

  def edit
    @checkin = Checkin.find(params[:id])
  end

  def create
    @checkin = Checkin.new(checkin_params)
    puts @checkin.errors unless @checkin.valid?
    respond_to do |format|
      if @checkin.save!
        build_new_assets
        format.html { redirect_to @checkin, notice: 'Checkin was successfully created.' }
        format.json { render json: @checkin, status: :created, location: @checkin }
      else
        format.html { render action: "new" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @checkin = Checkin.find(checkin_params)
    respond_to do |format|
      build_new_assets
      if @checkin.update_attributes(params[:checkin])
        format.html { redirect_to @checkin, notice: 'Checkin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy

    respond_to do |format|
      format.html { redirect_to checkins_url }
      format.json { head :no_content }
    end
  end

  private
  def checkin_params
    @user_id = current_user.id
    @params = params[:checkin]

    @params[:user_id] = current_user.id

    if @params[:categories_attributes]
      @params[:categories_attributes].each do |x|
        x[1][:user_id] = @user_id
      end
    end

    if @params[:people_attributes]
      @params[:people_attributes].each do |x|
        x[1][:user_id] = @user_id
      end
    end

    @params
  end

  def build_new_assets
    if params[:medias]
      params[:medias].each do |asset|
        Asset.create media: asset, checkin_id: @checkin.id, user_id: current_user.id
      end
    end
  end


end

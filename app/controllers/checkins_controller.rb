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

  def search
    @checkins = Checkin.belonging_to(current_user).near(params[:name_startsWith])
    render json: @checkins, root: false
  end

  def new
    @checkin = Checkin.new
    @id = @checkin.id || ''
  end

  def past
    @checkin = Checkin.new
    @id = @checkin.id || ''
  end

  def edit
    @checkin = Checkin.find(params[:id])
    @id = @checkin.id || ''

    respond_to do |format|
      format.html
      format.json { render json: @checkin }
    end
  end

  def create
    @checkin = Checkin.new(checkin_params)
    respond_to do |format|
      if @checkin.save
        build_new_assets
        format.html { redirect_to checkins_path, notice: 'Checkin was successfully created.' }
        format.json { render json: @checkin, status: :created, location: @checkin }
      else
        format.html { render action: 'new' }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @checkin = Checkin.find(params[:id])
    respond_to do |format|
      build_new_assets
      if @checkin.update_attributes(checkin_params)
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

  private
  def file_type media
    media.match(/^[a-zA-Z]*/).to_s
  end
  def build_new_assets
    if params[:medias]
      params[:medias].each do |asset|
        klass = case file_type(asset.content_type)
          when 'image' then Image
          when 'audio' then Audio
          when 'video' then Video
        end
        klass.create media: asset, checkin_id: @checkin.id, user_id: current_user.id
      end
    end
  end

end

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
    @category = params[:category]
    @query = params[:query]
    @checkins = case @category
      when 'people' then Person.find_by_name(@query).checkins
      when 'category' then Category.find_by_name(@query).checkins
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
    @checkin = Checkin.new(params[:checkin])
    @checkin.user_id = current_user.id
    puts @checkin.errors unless @checkin.valid?
    assign_people
    respond_to do |format|
      if @checkin.save!
        manage_assets_and_categories
        format.html { redirect_to @checkin, notice: 'Checkin was successfully created.' }
        format.json { render json: @checkin, status: :created, location: @checkin }
      else
        format.html { render action: "new" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @checkin = Checkin.find(params[:id])
    assign_people
    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        manage_assets_and_categories
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
  def manage_assets_and_categories
    if params[:medias]
      params[:medias].each do |asset|
        Asset.create media: asset, checkin_id: @checkin.id, user_id: current_user.id
      end
    end

    if @checkin.categories_checkins
      @checkin.categories_checkins.each { |x| x.checkin_id = @checkin.id; x.save }
    end

    if @checkin.categories
      @checkin.categories.each { |x| x.user_id = current_user.id; x.save }  if @checkin.categories
    end
  end

  def assign_people
    if @checkin.people
      @checkin.people.each { |person| person.user_id = current_user.id; person.save }
    end
  end

end

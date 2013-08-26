class CheckinsController < ApplicationController
  before_filter :authenticate

  # GET /checkins
  # GET /checkins.json
  def index
    @checkins = Checkin.belonging_to current_user

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkins }
    end
  end

  # GET /checkins/1
  # GET /checkins/1.json
  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checkin }
    end
  end

  def search
    @checkins = Checkin.near params[:location]
    render json: @checkins
  end

  # GET /checkins/new
  # GET /checkins/new.json
  def new
    @checkin = Checkin.new
  end

  def past
    @checkin = Checkin.new
  end

  # GET /checkins/1/edit
  def edit
    @checkin = Checkin.find(params[:id])
    @people = []
  end

  # POST /checkins
  # POST /checkins.json
  def create
    @checkin = Checkin.new(params[:checkin])
    @checkin.user_id = current_user.id
    assign_category
    respond_to do |format|
      if @checkin.save
        assign_people
        format.html { redirect_to @checkin, notice: 'Checkin was successfully created.' }
        format.json { render json: @checkin, status: :created, location: @checkin }
      else
        format.html { render action: "new" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checkins/1
  # PUT /checkins/1.json
  def update
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        format.html { redirect_to @checkin, notice: 'Checkin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.json
  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy

    respond_to do |format|
      format.html { redirect_to checkins_url }
      format.json { head :no_content }
    end
  end

  private
  def assign_category
    category_id = params[:checkin][:category_id]
    if category_id.empty?
      category = Category.create(name: params[:category][:name], user_id: current_user.id)
      @checkin.category_id = category.id
    else
      @checkin.category_id = category_id
    end
  end

  def assign_people
    if params[:people]
      params[:people].each do |person|
        PeopleCheckin.new(checkin_id: @checkin.id, person_id: person[:id])
      end
    end
    if @checkin.people
      @checkin.people.each do |person|
        person.user_id = current_user.id
        person.save
      end
    end
  end

end

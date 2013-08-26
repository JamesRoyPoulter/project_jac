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
  end

  # POST /checkins
  # POST /checkins.json
  def create
    @checkin = Checkin.new(params[:checkin])
    @checkin.user_id = current_user.id
    puts @checkin.errors unless @checkin.valid?
    respond_to do |format|
      if @checkin.save!
        assign_people
        assign_checkin_to_categories
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
  def assign_checkin_to_categories
    @checkin.categories_checkins.each { |x| x.checkin_id = @checkin.id }
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

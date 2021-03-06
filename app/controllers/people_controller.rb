class PeopleController < ApplicationController
  before_filter :authenticate_user!
  def index
    @people = current_user.people

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  def search
    if params[:name_startsWith]
      @people = current_user.people.where(
        'name ilike ?', "%#{params[:name_startsWith]}%"
      )
      render json: @people, root: false
    else
      @person = current_user.people.where(
        'name ilike ?', "%#{params[:name]}%"
      ).first
      render json: @person.checkins, root: false
    end
  end

  def show
    @person = Person.find(params[:id])
    @checkins = @person.checkins

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to people_url, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to people_url, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  private
    def person_params
      params[:person][:user_id] = current_user.id
      params[:person]
    end

end

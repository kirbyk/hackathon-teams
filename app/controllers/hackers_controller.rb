class HackersController < ApplicationController
  before_filter :authenticate_user!, :prepare_schools, :prepare_teams
  before_action :set_hacker, only: [:show, :edit, :update, :destroy]

  # GET /hackers
  # GET /hackers.json
  def index
    # @hackers = Hacker.all.group("team_id")
    @hackers = Hacker.all.to_a
  end

  # GET /hackers/1
  # GET /hackers/1.json
  def show
  end

  # GET /hackers/new
  def new
    @hacker = Hacker.new
  end

  # GET /hackers/1/edit
  def edit
  end

  # POST /hackers
  # POST /hackers.json
  def create
    @hacker = Hacker.new(hacker_params)

    respond_to do |format|
      if @hacker.save
        format.html { redirect_to @hacker, notice: 'Hacker was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hacker }
      else
        format.html { render action: 'new' }
        format.json { render json: @hacker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hackers/1
  # PATCH/PUT /hackers/1.json
  def update
    respond_to do |format|
      if @hacker.update(hacker_params)
        format.html { redirect_to @hacker, notice: 'Hacker was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hacker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hackers/1
  # DELETE /hackers/1.json
  def destroy
    @hacker.destroy
    respond_to do |format|
      format.html { redirect_to hackers_url }
      format.json { head :no_content }
    end
  end

  private
    # add the @schools = School.all to the before action so avail for all actions  
    def prepare_schools
      @schools = School.all
    end

    # add the @teams = Team.all to the before action so avail for all actions  
    def prepare_teams
      @teams = Team.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_hacker
      @hacker = Hacker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hacker_params
      params.require(:hacker).permit(:fname, :lname, :school, :school_id, :team, :team_id, :email, :github, :tshirt_size, :why)
    end
end

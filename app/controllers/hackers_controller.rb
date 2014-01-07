class HackersController < ApplicationController
  before_filter :prepare_schools, :prepare_teams, :prepare_statuses, :prepare_tshirts
  before_action :authenticate_user!, :except => [:commit, :commited, :update, :update_commit]
  before_action :set_hacker, only: [:show, :edit, :update, :destroy, :update_commit]
  helper_method :sort_column, :sort_direction

  # GET /hackers
  # GET /hackers.json
  def index
    # @hackers = Hacker.all.group("team_id")
    @hackers = Hacker.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 200)
  end

  # GET /hackers/1
  # GET /hackers/1.json
  def show
  end

  def commit
  end

  def commited
    if Hacker.find_by_email(params[:email])
      @hacker = Hacker.find_by_email(params[:email])
    else
      @hacker = nil
    end
  end

  def update_commit
    respond_to do |format|
      if @hacker.update(hacker_params)
        @hacker.status_id = Status.find_by_name('Commited').id
        @hacker.save
        flash[:notice] = "You have successfully commited to attending BoilerMake!"
        format.html { redirect_to action: 'commited', email: @hacker.email }
      else
        flash[:notice] = "There was an error with your commitment to BoilerMake. Please make sure to upload your resume as a PDF. If problems persist email - kirby@purdue.edu."
        format.html { render action: 'commited', email: @hacker.email }
      end
    end
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
    def prepare_schools
      @schools = School.all
    end

    def prepare_teams
      @teams = Team.all
    end

    def prepare_statuses
      @statuses = Status.all
    end

    def prepare_tshirts
      @tshirts = ['XS', 'Small', 'Medium', 'Large', 'XL', 'XXL', '3XL']
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_hacker
      @hacker = Hacker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hacker_params
      params.require(:hacker).permit(:fname, :lname, :school, :school_id, :team, :team_id, :contact_date, :status, :status_id, :email, :github, :tshirt_size, :why, :resume)
    end

    def sort_column
      Hacker.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end

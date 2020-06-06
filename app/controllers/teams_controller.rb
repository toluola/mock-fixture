class TeamsController < ApplicationController
  skip_before_action :check_admin, only: [:index]
  include Response
  include ExceptionHandler

  # GET root route action
  def root
    json_response({ message: "Welcome to the base URL"}, "This is the base URL")
  end

  # POST /teams
  def create
    team = Team.create!(team_params)
    json_response(team, "Team created successfully", :created)
  end

  # GET /teams
  def index
    teams = Team.all
    json_response(teams, "Teams fetched successfully")
  end

  # GET /teams/:id
  def show
    json_response(set_team, "Team Fetched successfully")
  end

  # DELETE /teams/:id
  def destroy
    team = Team.destroy(params[:id])
    json_response(team, "Team deleted successfully")
  end

  # PUT /teams/:id
  def update
    team = set_team.update(team_params)
    json_response(team, "Team updated successfully")
  end


  private 

  def team_params
    # whitelist params
    params.permit(:name)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end

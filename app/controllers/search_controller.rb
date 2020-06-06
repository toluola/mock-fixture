class SearchController < ApplicationController
  skip_before_action :authorize_user, :check_admin, only: [:search_team, :search_fixture]
  include Response
  include ExceptionHandler

  def search_team
    @search_team = Team.search_by_name(params[:query])
    if @search_team.length == 0
      return json_response(@search_team, "No record found")
    end
    json_response(@search_team, "Team searched successfully")
  end

  def search_fixture
    @search_fixture = Fixture.search_by_home_away_team(params[:query])
    if @search_fixture.length == 0
      return json_response(@search_fixture, "No record found")
    end
    json_response(@search_fixture, "Fixture searched successfully")
  end
end

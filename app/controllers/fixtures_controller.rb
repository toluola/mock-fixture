class FixturesController < ApplicationController
  skip_before_action :check_admin, only: [:index, :view_completed_fixtures, :view_pending_fixtures]
  include Response
  include ExceptionHandler

  # POST /fixtures
  def create
    fixture = Fixture.create!(fixture_params)
    json_response(fixture, "Fixture created successfully", :created)
  end

  # GET /fixtures
  def index
    fixtures = $redis.get("fixtures")

    if fixtures.nil?
      fixtures = Fixture.all.to_json
      $redis.set("fixtures", fixtures)
      $redis.expire("fixtures", 3.hour.to_i)
    end
    @fixtures = JSON.load fixtures
    json_response(@fixtures, "Fixtures fetched successfully")
  end

  # GET /fixtures/:id
  def show
    json_response(set_fixture, "Fixture Fetched successfully")
  end

  # DELETE /fixtures/:id
  def destroy
    fixture = Fixture.destroy(params[:id])
    json_response(fixture, "Fixture deleted successfully")
  end

  # PUT /fixtures/:id
  def update
    fixture = set_fixture.update(fixture_params)
    json_response(fixture, "Fixture updated successfully")
  end

  # GET completed fixtures
  def view_completed_fixtures
    fixture = Fixture.where("date_time < ?", Time.now)
    json_response(fixture, "Completed fixtures fetched successfully")
  end

  # GET pending fixtures
  def view_pending_fixtures
    fixture = Fixture.where("date_time > ?", Time.now)
    json_response(fixture, "Pending fixtures fetched successfully")
  end

  def generate_fixture_link
    link = "#{ENV["BASE_URL"] + "fixtures/" + set_fixture.id}"
    json_response({ link: link }, "Fixture link fetched successfully")
  end

  private 

  def fixture_params
    # whitelist params
    params.permit(:home_team, :away_team, :date_time)
  end

  def set_fixture
    @fixture = Fixture.find(params[:id])
  end
end

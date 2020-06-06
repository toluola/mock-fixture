require "rails_helper"

RSpec.describe "Search API", type: :request do
  let!(:user) { create(:user) }
  let!(:team) { create(:team) }
  let(:team_name) { team.name }
  let(:headers) { valid_headers }

  describe "Get /search/teams" do

    context "when the request is valid" do
      before { get "/search/teams?query=#{team_name}", params: {}, headers: headers }
      it "returns search content" do
        expect(json).not_to be_empty
      end

      it "returns 200 status" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is not valid" do
      before { post "/teams", params: {}, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end
end
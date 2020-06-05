require "rails_helper"

RSpec.describe "Product API", type: :request do
  let!(:user) { create(:user) }
  let!(:team) { create(:team) }
  let(:team_id) { team.id }
  let(:headers) { valid_headers }

  describe "GET /teams" do
    before { get "/teams", params: {}, headers: headers }
    it "returns teams" do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /teams/:id" do
    before { get "/teams/#{team_id}", params: {}, headers: headers }

    context "when the record exists" do
      it "returns teams" do
        expect(json).not_to be_empty
        expect(json["data"]["id"]).to eq(team_id)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:team_id) { 100 }
      it "returns 404 status code" do
        expect(response).to have_http_status(404)
      end
      it "returns not found message" do
        expect(json["message"]).to match(/Couldn't find Team with 'id'=100/)
      end
    end
  end

  describe "POST /teams" do
    let(:valid_atrributes) do 
      { name: "chelsea" }.to_json
    end

    context "when the request is valid" do
      before { post "/teams", params: valid_atrributes, headers: headers }
      it "creates a team" do
        expect(json["data"]["name"]).to eq("chelsea")
      end

      it "returns 201 status" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is not valid" do
      before { post "/teams", params: {}, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /teams/:id" do
    before { put "/teams/#{team_id}", params: {}, headers: headers }

    it "returns status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /teams/:id" do
    before { delete "/teams/#{team_id}", headers: headers }

    it "returns status code of 200" do
      expect(response).to have_http_status(200)
    end
  end
end

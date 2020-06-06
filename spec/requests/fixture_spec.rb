require "rails_helper"

RSpec.describe "Fixtures API", type: :request do
  let!(:user) { create(:user) }
  let!(:fixture) { create(:fixture) }
  let(:fixture_id) { fixture.id }
  let(:headers) { valid_headers }

  describe "GET /fixtures" do
    before { get "/fixtures", params: {}, headers: headers }
    it "returns fixtures" do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /fixtures/:id" do
    before { get "/fixtures/#{fixture_id}", params: {}, headers: headers }

    context "when the record exists" do
      it "returns teams" do
        expect(json).not_to be_empty
        expect(json["data"]["id"]).to eq(fixture_id)
      end
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:fixture_id) { 100 }
      it "returns 404 status code" do
        expect(response).to have_http_status(404)
      end
      it "returns not found message" do
        expect(json["message"]).to match(/Couldn't find Fixture with 'id'=100/)
      end
    end
  end

  describe "POST /fixtures" do
    let(:valid_atrributes) do 
      { home_team: "chelsea", away_team: "liverpool", date_time: "3rd Jul 2020 04:05:06 PM" }.to_json
    end

    context "when the request is valid" do
      before { post "/fixtures", params: valid_atrributes, headers: headers }
      it "creates a fixture" do
        expect(json["data"]["home_team"]).to eq("chelsea")
        expect(json["data"]["away_team"]).to eq("liverpool")
      end

      it "returns 201 status" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is not valid" do
      before { post "/fixtures", params: {}, headers: headers }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /fixtures/:id" do
    before { put "/fixtures/#{fixture_id}", params: {}, headers: headers }

    it "returns status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /fixtures/:id" do
    before { delete "/fixtures/#{fixture_id}", headers: headers }

    it "returns status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /fixtures/completed" do
    before { get "/fixtures/completed", params: {}, headers: headers }
    it "returns fixtures" do
      expect(json).not_to be_empty
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET /fixtures/pending" do
    before { get "/fixtures/pending", params: {}, headers: headers }
    it "returns fixtures" do
      expect(json).not_to be_empty
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET /fixtures/:id/link" do
    before { get "/fixtures/#{fixture_id}/link", params: {}, headers: headers }
    it "returns fixtures" do
      expect(json).not_to be_empty
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end 
end
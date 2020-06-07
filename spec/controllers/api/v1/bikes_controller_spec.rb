require "rails_helper"

RSpec.describe Api::V1::BikesController, type: :controller do
  let(:invalid_session) { {} }
  let(:user) { create(:user, email: "foo@foo.foo") }
  let(:valid_session) { { user_id: user.id } }

  context "ensure authentication" do
    it "returns a not successful response when not logged in" do
      get :index, params: {}, session: invalid_session
      expect(response).to_not be_successful
    end

    it "returns a successful response when logged in" do
      create(:user)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  context "#index" do

    let!(:bikes) { 
      [
        create(:bike, user: user, name: "patrol"),
        create(:bike, user: user, name: "nomad"),
      ]
     }

    it "returns the users bikes" do
      expected_json = [
        { id: bikes.first.id, name: "patrol" }, 
        { id: bikes.second.id, name: "nomad" }, 
      ].to_json

      get :index, params: {}, session: valid_session
      expect(response).to be_successful
      expect(response.body).to eq expected_json
    end
  end
end

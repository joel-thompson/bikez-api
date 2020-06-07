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
      expected_json = ActiveModel::SerializableResource.new(
        bikes, 
        each_serializer: BikeSerializer
      ).to_json

      get :index, params: {}, session: valid_session
      expect(response).to be_successful
      expect(response.body).to eq expected_json
    end
  end

  context "#show" do
    let!(:bike) { create(:bike, user: user, name: "patrol") }

    it "returns the bike json" do
      expected_json = BikeSerializer.new(bike).to_json

      get :show, params: {id: bike.id}, session: valid_session
      expect(response).to be_successful
      expect(response.body).to eq expected_json
    end

    it "returns 404 if the bike cant be found" do
      get :show, params: {id: 500}, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "bike not found"
    end

    it "returns 404 if the bike belongs to another user" do
      bike = create(:bike)
      get :show, params: {id: bike.id}, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "bike not found"
    end
  end

  context "#create" do
    it "creates a bike" do
      expect{
        post :create, params: { name: "new bike" }, session: valid_session
      }.to change{Bike.count}.from(0).to(1)

      expect(response).to be_successful
    end

    it "returns the json" do
      new_bike = create(:bike, user: user, name: "new bike")

      expect(Bike).to receive(:create).with(
        user: user,
        name: new_bike.name,
      ).and_return(new_bike)

      post :create, params: { name: new_bike.name }, session: valid_session

      expect(response).to be_successful
      expect(response.body).to eq(BikeSerializer.new(new_bike).to_json)
    end

    it "returns errors if unable to create" do
      post :create, params: { name: nil }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 400
      expect(JSON.parse(response.body)["errors"]).to include "Name can't be blank"
    end
  end

  context "#update" do

    let(:bike) { create(:bike, user: user, name: "update me") }

    it "updates the bike and returns the correct json" do
      put :update, params: { id: bike.id, name: "updated name" }, session: valid_session
      expect(response).to be_successful
      bike.reload
      expect(bike.name).to eq "updated name"
      expect(response.body).to eq(BikeSerializer.new(bike).to_json)
    end

    it "returns errors if unable to update" do
      put :update, params: { id: bike.id, name: nil }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 400
      expect(JSON.parse(response.body)["errors"]).to include "Name can't be blank"
    end

    it "returns 404 if the bike cant be found" do
      put :update, params: { id: 500, name: "updated name" }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "bike not found"
    end

    it "returns 404 if the bike belongs to another user" do
      bike = create(:bike)
      put :update, params: { id: bike.id, name: "updated name" }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "bike not found"
    end
  end

  context "#destroy" do
    it "deletes the bike" do
      bike = create(:bike, user: user, name: "delete me")
      expect {
        delete :destroy, params: { id: bike.id }, session: valid_session
      }.to change{ Bike.count }.by(-1)
    end

    it "returns 404 if the bike cant be found" do
      delete :destroy, params: { id: 500 }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "bike not found"
    end

    it "returns 404 if the bike belongs to another user" do
      bike = create(:bike)
      delete :destroy, params: { id: bike.id }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "bike not found"
    end
  end
end

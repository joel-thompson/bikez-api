require "rails_helper"

RSpec.describe Api::V1::SuspensionPartsController, type: :controller do
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
    let!(:parts) { 
      [
        create(:suspension_part, user: user, name: 'fox 36'),
        create(:suspension_part, user: user, name: 'rockshox coil')
      ]
     }

     it "returns the users suspension parts" do
      expected_json = ActiveModelSerializers::SerializableResource.new(
        parts, 
        each_serializer: SuspensionPartSerializer
      ).to_json

      get :index, params: {}, session: valid_session
      expect(response).to be_successful
      expect(response.body).to eq expected_json
     end

     it "returns specified suspension parts if ids is passed" do
      part1 = create(:suspension_part, user: user, name: "fork1")
      part2 = create(:suspension_part, user: user, name: "fork2")
      part3 = create(:suspension_part, user: user, name: "fork3")

      expected_json = ActiveModelSerializers::SerializableResource.new(
        [part1, part2], 
        each_serializer: SuspensionPartSerializer
      ).to_json

      get :index, params: {ids: [part1.id, part2.id]}, session: valid_session
      expect(response).to be_successful
      expect(response.body).to eq expected_json
    end
  end

  context "#show" do
    let(:part) { create(:suspension_part, user: user, name: 'fox 36') }

    it "returns the part json" do
      expected_json = SuspensionPartSerializer.new(part).to_json

      get :show, params: { id: part.id }, session: valid_session
      expect(response).to be_successful
      expect(response.body).to eq expected_json
    end

    it "returns 404 if the part cant be found" do
      get :show, params: {id: 500}, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "suspension part not found"
    end

    it "returns 404 if the part belongs to another user" do
      part = create(:suspension_part)
      get :show, params: {id: part.id}, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "suspension part not found"
    end
  end

  context "#create" do
    it "creates a part" do
      expect{
        post :create, params: { name: "new fork", component_type: "fork" }, session: valid_session
      }.to change{SuspensionPart.count}.from(0).to(1)

      expect(response).to be_successful
    end

    it "returns the json" do
      new_part = create(:suspension_part, user: user, name: "new fork", component_type: "fork")

      expect(SuspensionPart).to receive(:create).with(
        user: user,
        name: new_part.name,
        component_type: new_part.component_type,
      ).and_return(new_part)

      post :create, params: { name: new_part.name, component_type: "fork" }, session: valid_session

      expect(response).to be_successful
      expect(response.body).to eq(SuspensionPartSerializer.new(new_part).to_json)
    end

    it "returns errors if unable to create" do
      post :create, params: { name: nil }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 400
      expect(JSON.parse(response.body)["errors"]).to include "Name can't be blank"
      expect(JSON.parse(response.body)["errors"]).to include "Component type can't be blank"
    end

    it "uses the correct non-default values" do
      new_part = create(
        :suspension_part, 
        user: user, 
        name: "new fork", 
        component_type: "fork",
        high_speed_compression: true,
        low_speed_compression: false,
        high_speed_rebound: true,
        low_speed_rebound: false,
        volume: false,
        pressure: false,
        spring_rate: true,
      )

      expect(SuspensionPart).to receive(:create).with(
        user: user,
        name: new_part.name,
        component_type: new_part.component_type,
        high_speed_compression: new_part.high_speed_compression.to_s,
        low_speed_compression: new_part.low_speed_compression.to_s,
        high_speed_rebound: new_part.high_speed_rebound.to_s,
        low_speed_rebound: new_part.low_speed_rebound.to_s,
        volume: new_part.volume.to_s,
        pressure: new_part.pressure.to_s,
        spring_rate: new_part.spring_rate.to_s,
      ).and_return(new_part)

      post :create, params: { 
        name: new_part.name, 
        component_type: "fork",
        high_speed_compression: true,
        low_speed_compression: false,
        high_speed_rebound: true,
        low_speed_rebound: false,
        volume: false,
        pressure: false,
        spring_rate: true,
      }, session: valid_session

      expect(response).to be_successful
      expect(response.body).to eq(SuspensionPartSerializer.new(new_part).to_json)
    end
  end

  context "#update" do
    let(:part) { create(:suspension_part, user: user, name: "update me", component_type: "fork", volume: true) }

    it "updates the part and returns the correct json" do
      put :update, params: { id: part.id, name: "updated name", volume: false }, session: valid_session
      expect(response).to be_successful
      part.reload
      expect(part.name).to eq "updated name"
      expect(part.volume).to eq false
      expect(response.body).to eq(SuspensionPartSerializer.new(part).to_json)
    end

    it "returns errors if unable to update" do
      put :update, params: { id: part.id, name: nil }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 400
      expect(JSON.parse(response.body)["errors"]).to include "Name can't be blank"
      part.reload
      expect(part.name).to eq "update me"
    end

    it "returns 404 if the part cant be found" do
      put :update, params: { id: 500, name: "updated name" }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "suspension part not found"
    end

    it "returns 404 if the bike belongs to another user" do
      part = create(:suspension_part)
      put :update, params: { id: part.id, name: "updated name" }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "suspension part not found"
    end
  end

  context "#destroy" do
    it "deletes the bike and returns the delete status" do
      part = create(:suspension_part, user: user, name: "delete me")
      expect {
        delete :destroy, params: { id: part.id }, session: valid_session
      }.to change{ SuspensionPart.count }.by(-1)
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq({ "status" => 'deleted' })
    end

    it "returns 404 if the bike cant be found" do
      delete :destroy, params: { id: 500 }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "suspension part not found"
    end

    it "returns 404 if the bike belongs to another user" do
      bike = create(:suspension_part)
      delete :destroy, params: { id: bike.id }, session: valid_session
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)["errors"]).to include "suspension part not found"
    end
  end
end

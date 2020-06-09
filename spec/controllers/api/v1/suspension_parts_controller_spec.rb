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

  end

  context "#show" do

  end

  context "#create" do

  end

  context "#update" do

  end

  context "#destroy" do

  end
end

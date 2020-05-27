require "rails_helper"

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:invalid_session) { {} }
  let(:user) { create(:user, email: "foo@foo.foo") }
  let(:valid_session) { { user_id: user.id } }

  describe "GET #index" do
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
end

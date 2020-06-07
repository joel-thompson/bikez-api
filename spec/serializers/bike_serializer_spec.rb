require 'rails_helper'

RSpec.describe BikeSerializer do
  let(:user) { create(:user) }
  let(:bike) { create(:bike, user: user) }
  let(:subject) { BikeSerializer.new(bike).to_json }

  context "serializing" do
    it "returns the correct json" do
      expected_output = { 
        id: bike.id, 
        name: bike.name,
        # active_suspension_parts: [],
      }.to_json

      expect(subject).to eq expected_output
    end
  end
end

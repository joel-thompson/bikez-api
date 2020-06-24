require 'rails_helper'

RSpec.describe BikeSerializer do
  let(:user) { create(:user) }
  let(:bike) { create(:bike, user: user) }
  let(:subject) { BikeSerializer.new(bike).to_json }

  let(:part1) { create(:suspension_part, user: user, name: "part1", component_type: "fork") }
  let(:part2) { create(:suspension_part, user: user, name: "part2", component_type: "shock") }
  let!(:suspension_parts) {[ part1,part2 ]}
  let!(:suspension_part_assignments) { 
    [
      create(:suspension_part_assignment, suspension_part: part1, bike: bike),
      create(:suspension_part_assignment, suspension_part: part2, bike: bike),
    ] 
  }

  context "serializing" do
    it "returns the correct json" do
      expected_output = { 
        id: bike.id, 
        name: bike.name,
        active_suspension_part_ids: [part1.id, part2.id]
      }.to_json

      expect(subject).to eq expected_output
    end
  end
end

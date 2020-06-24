require 'rails_helper'

RSpec.describe SuspensionPartSerializer do
  let(:user) { create(:user) }
  let(:suspension_part) { create(:suspension_part, user: user) }
  let(:subject) { SuspensionPartSerializer.new(suspension_part).to_json }

  context "serializing" do
    it "returns the correct json" do
      expected_output = { 
        id: suspension_part.id,
        name: suspension_part.name,
        component_type: suspension_part.component_type,
        high_speed_compression: suspension_part.high_speed_compression,
        low_speed_compression: suspension_part.low_speed_compression,
        high_speed_rebound: suspension_part.high_speed_rebound,
        low_speed_rebound: suspension_part.low_speed_rebound,
        volume: suspension_part.volume,
        pressure: suspension_part.pressure,
        spring_rate: suspension_part.spring_rate,
      }.to_json
      expect(subject).to eq expected_output
    end
  end
end

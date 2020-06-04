require 'rails_helper'

RSpec.describe SuspensionPartAssignment, type: :model do
  context "validations" do

    context "valid assignment" do
      it "is valid" do
        user = create(:user)
        bike = create(:bike, user: user)
        part = create(:suspension_part, user: user)
        assign = create(:suspension_part_assignment, suspension_part: part, bike: bike)
        expect(assign.valid?).to eq true
      end
    end

    context "requires a bike" do
      it "fails without a bike" do
        assign = build(:suspension_part_assignment, bike: nil)
        expect(assign.valid?).to eq false
      end
    end

    context "requires a suspension_part" do
      it "fails without a suspension part" do
        assign = build(:suspension_part_assignment, suspension_part: nil)
        expect(assign.valid?).to eq false
      end
    end
  end
end

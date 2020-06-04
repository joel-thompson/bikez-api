require 'rails_helper'

RSpec.describe SuspensionPartAssignment, type: :model do

  let(:user) { create(:user) }
  let(:bike) { create(:bike, user: user) }
  let(:part) { create(:suspension_part, user: user) }

  context "validations" do
    context "valid assignment" do
      it "is valid" do
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

  context "state of the nation" do
    context "when it is active" do
      it "is active" do
        assign = create(:suspension_part_assignment, suspension_part: part, bike: bike, assigned_at: Time.now)
        expect(assign.active?).to eq true
      end
    end

    context "when it is not active" do
      it "is not active" do
        assign = create(:suspension_part_assignment, suspension_part: part, bike: bike, assigned_at: Time.now - 5.days, removed_at: Time.now - 1.day)
        expect(assign.active?).to eq false
      end
    end
  end
end

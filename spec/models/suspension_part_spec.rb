require 'rails_helper'

RSpec.describe SuspensionPart, type: :model do
  context "validations" do
    context "valid part" do
      it "is valid" do
        part = create(:suspension_part)
        expect(part.valid?).to eq true
      end
    end

    context "requires a user" do
      it "fails without a user" do
        part = build(:suspension_part, user: nil)
        expect(part.valid?).to eq false
      end
    end

    context "only allows types defined in VALID_TYPES" do
      it "fails for component_type = wheel" do
        part = build(:suspension_part, component_type: "wheel")
        expect(part.valid?).to eq false
      end

      it "passes for component_type = fork" do
        part = build(:suspension_part, component_type: "fork")
        expect(part.valid?).to eq true
      end

      it "passes for component_type = shock" do
        part = build(:suspension_part, component_type: "shock")
        expect(part.valid?).to eq true
      end
    end

    context "required attributes are always filled in" do
      it "fails if any of the required attributes are not set" do
        part = build(:suspension_part, name: nil)
        expect(part.valid?).to eq false

        part = build(:suspension_part, component_type: nil)
        expect(part.valid?).to eq false

        part = build(:suspension_part, high_speed_compression: nil)
        expect(part.valid?).to eq false

        part = build(:suspension_part, low_speed_compression: nil)
        expect(part.valid?).to eq false

        part = build(:suspension_part, high_speed_rebound: nil)
        expect(part.valid?).to eq false
      end
    end
  end

  context "state of the nation" do

    let(:user) { create(:user) }
    let(:bike) { create(:bike, user: user) }
    let(:part) { create(:suspension_part, user: user) }

    context "finding the active suspension part assignments" do
      it "finds the active assignment" do
        inactive_assign = create(:suspension_part_assignment, suspension_part: part, bike: bike, assigned_at: Time.now - 5.days, removed_at: Time.now - 1.day)
        active_assign = create(:suspension_part_assignment, suspension_part: part, bike: bike, assigned_at: Time.now - 1.days)

        assigns = part.active_suspension_part_assignments
        expect(assigns.count).to eq 1
        expect(assigns.first).to eq active_assign
      end
    end
  end
end

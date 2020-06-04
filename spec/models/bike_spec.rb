require "rails_helper"

RSpec.describe Bike, type: :model do
  context "validations" do
    context "valid bike" do
      it "is valid" do
        bike = create(:bike)
        expect(bike.valid?).to eq true
      end
    end

    context "requires a user" do
      it "fails without a user" do
        bike = build(:bike, user: nil)
        expect(bike.valid?).to eq false
      end
    end

    context "requires a name" do
      it "fails without a name" do
        bike = build(:bike, name: nil)
        expect(bike.valid?).to eq false
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

        assigns = bike.active_suspension_part_assignments
        expect(assigns.count).to eq 1
        expect(assigns.first).to eq active_assign
      end
    end
  end
end

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

  context ".active_suspension_parts" do
    let(:user) { create(:user) }
    let(:bike) { create(:bike, user: user) }
    let(:fork) { create(:suspension_part, user: user, name: "fox 36", component_type: "fork") }
    let(:shock) { create(:suspension_part, user: user, name: "rockshox coil", component_type: "shock") }
    let(:shock2) { create(:suspension_part, user: user, name: "fox dpx2", component_type: "shock") }

    it "finds the active parts when used without a specific time" do
      create(:suspension_part_assignment, bike: bike, suspension_part: fork, assigned_at: Time.now - 1.minute)
      create(:suspension_part_assignment, bike: bike, suspension_part: shock, assigned_at: Time.now - 1.minute)
      create(:suspension_part_assignment, bike: bike, suspension_part: shock2, assigned_at: Time.now - 2.days, removed_at: Time.now - 1.minute)

      expect(bike.active_suspension_parts).to match_array([fork, shock])
    end

    it "finds the active parts when used with a specific time" do
      create(:suspension_part_assignment, bike: bike, suspension_part: fork, assigned_at: Time.now - 10.days, removed_at: Time.now - 5.days)
      create(:suspension_part_assignment, bike: bike, suspension_part: shock, assigned_at: Time.now - 10.days, removed_at: Time.now - 5.days)
      create(:suspension_part_assignment, bike: bike, suspension_part: shock2, assigned_at: Time.now - 5.days)

      expect(bike.active_suspension_parts(Time.now - 9.days)).to match_array([fork, shock])
    end

  end
end

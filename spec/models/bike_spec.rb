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
end

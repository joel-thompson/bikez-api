require 'rails_helper'

RSpec.describe SuspensionPart, type: :model do
  context "validations" do

    context "requires a user" do
      it "fails without a user" do
        part = build(:suspension_part, user: nil)
        expect(part.valid?).to eq false
      end
    end

    context "only allows types defined in VALID_TYPES" do
      it "fails for type = wheel" do
        part = build(:suspension_part, type: "wheel")
        expect(part.valid?).to eq false
      end

      it "passes for type = fork" do
        part = build(:suspension_part, type: "fork")
        expect(part.valid?).to eq true
      end

      it "passes for type = shock" do
        part = build(:suspension_part, type: "shock")
        expect(part.valid?).to eq true
      end
    end

    context "required attributes are always filled in" do
      it "fails if any of the required attributes are not set" do
        part = build(:suspension_part, name: nil)
        expect(part.valid?).to eq false

        part = build(:suspension_part, type: nil)
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
end

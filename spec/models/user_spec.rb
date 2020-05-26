require "rails_helper"

RSpec.describe User, type: :model do
  it "returns fred" do
    expect("fred").to eq "fred"
  end
end

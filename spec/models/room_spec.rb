require "rails_helper"

describe Room do
  describe "factory and validations" do
    it { expect(Room.new).to be_invalid }
    it { expect(FactoryGirl.build(:room)).to be_valid }
    it { expect(FactoryGirl.build(:room, venue_id: nil)).to be_invalid }
  end
end

require "rails_helper"

describe Room do
  describe "factory and validations" do
    it { expect(Room.new).to be_invalid }
    it { expect(FactoryGirl.build(:room)).to be_valid }
    it { expect(FactoryGirl.build(:room, venue_id: nil)).to be_invalid }
  end

  describe "to_csv" do
    let(:room) { FactoryGirl.create(:room) }
    let(:expected_line) {[
      room.venue.name, room.venue.email, room.venue.phone,
      room.venue.street, room.venue.postal_code, room.venue.city,
      room.venue.country, room.venue.website, room.venue.kind,
      room.venue.residency, room.venue.accompaniment,
      room.venue.network_tags, room.venue.custom_tags,
      room.venue.season_months, room.venue.style_tags,
      room.venue.contract_tags, room.venue.discovery,
      room.venue.period, room.venue.scheduling_remark,
      room.venue.prospecting_months, room.venue.remark,
      room.name, room.seating, room.standing, room.modular_space,
     "#{room.depth} x #{room.width} x #{room.height}", room.bar
    ].to_csv}

    it { expect(room.to_csv).to eq(expected_line) }

  end
end

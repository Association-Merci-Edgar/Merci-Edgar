require "rails_helper"

describe Venue do

  describe "valid factory" do
    it { expect(FactoryGirl.build(:venue)).to be_valid }
  end

  describe "export" do
    context "with an account with a person" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:laclef) { FactoryGirl.create(:venue, account_id: account.id) }

      it { expect(File.basename(Venue.export(account))).to eq("lieux-#{account.domain}.csv") }

      it { expect(File.readlines(Venue.export(account)).sort).to eq([laclef.to_csv, Venue.csv_header].sort) }
    end
  end

  describe "to_csv" do
    let(:laclef) { FactoryGirl.create(:venue) }

    # Missing capacities and person (regisseur, programmateur ...)
    let(:expected_line) {[
      laclef.name, laclef.email, laclef.phone,
      laclef.street, laclef.postal_code, laclef.city,
      laclef.country, laclef.website, laclef.kind,
      laclef.residency, laclef.accompaniment,
      laclef.network_tags, laclef.custom_tags,
      laclef.season_months, laclef.style_tags,
      laclef.contract_tags, laclef.discovery,
      laclef.period, laclef.scheduling_remark,
      laclef.prospecting_months, laclef.remark
    ].to_csv}

    it { expect(laclef.to_csv).to eq(expected_line) }
  end

  describe "capacity_tags" do

    let(:account) { FactoryGirl.create(:account) }
    before(:each) { Account.current_id = account.id }

    context "without room" do
      let(:venue) { FactoryGirl.create(:venue, account_id: account.id) }
      it { expect(venue.capacity_tags).to eq([]) }
    end

    context "with just a room" do
      context "with 45 seats and 200 standing" do
        let(:venue) { FactoryGirl.create(:venue, account_id: account.id) }
        let(:room) { FactoryGirl.create(:room, seating: 45, standing: 200, venue_id: venue.id) }
        it { expect(room.venue.capacity_tags).to eq(['< 100', '100-400']) }
      end

      context "with 4500 seats and 0 standing" do
        let(:venue) { FactoryGirl.create(:venue, account_id: account.id) }
        let(:room) { FactoryGirl.create(:room, seating: 4500, standing: 0, venue_id: venue.id) }
        it { expect(room.venue.capacity_tags).to eq(['> 1200']) }
      end

      context "with 423 seats and 1500 standing" do
        let(:venue) { FactoryGirl.create(:venue, account_id: account.id) }
        let(:room) { FactoryGirl.create(:room, seating: 423, standing: 1500, venue_id: venue.id) }
        it { expect(room.venue.capacity_tags).to eq(['401-1200', '> 1200']) }
      end
    end

    context "with 2 rooms" do
      let!(:venue) { FactoryGirl.create(:venue, account_id: account.id) }
      let!(:first_room) { FactoryGirl.create(:room, seating: 423, standing: 1500, venue_id: venue.id) }
      let!(:second_room) { FactoryGirl.create(:room, seating: 0, standing: 500, venue_id: venue.id) }

      it { expect(first_room.venue.capacity_tags).to eq(['401-1200', '> 1200']) }
    end
  end

end

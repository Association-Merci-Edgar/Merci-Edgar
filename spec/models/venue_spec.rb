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
end

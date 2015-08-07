require "rails_helper"

describe Structure do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:structure)).to be_valid }
    it { expect(FactoryGirl.build(:structure, :generic)).to be_valid }
  end

  describe "export" do
    context "with an account with a generic structure" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:structure) { FactoryGirl.create(:structure, :generic, account_id: account.id) }

      it { expect(File.basename(Structure.export(account))).to eq("structures-#{account.domain}.csv") }
      it { expect(File.readlines(Structure.export(account)).sort).to eq([structure.to_csv, Structure.csv_header].sort) }
    end
  end

  describe "to_csv" do
    context "with a show buyer only" do
      let(:structure) { FactoryGirl.create(:structure, :generic) }

      let(:expected_line) {[structure.name, ExportTools.build_list(structure.emails), ExportTools.build_list(structure.phones), ExportTools.build_list(structure.addresses), ExportTools.build_list(structure.websites), structure.network_list, structure.custom_list, structure.remark, ExportTools.build_list(structure.people)
      ].to_csv}

      it { expect(structure.to_csv).to eq(expected_line) }
    end
  end

  describe "to_s" do
    context "with a venue" do
      let(:contact) { FactoryGirl.create(:contact, name: 'La Clef') }
      let(:venue) { FactoryGirl.create(:structure, contact: contact, structurable_type: :venue ) }
      it { expect(venue.to_s).to eq('La Clef [Lieu]') }
    end
    context "with a generic structure" do
      let(:contact) { FactoryGirl.create(:contact, name: 'La Clef') }
      let(:structure) { FactoryGirl.create(:structure, contact: contact, structurable_type: nil ) }
      it { expect(structure.to_s).to eq('La Clef [Structure générique]') }
    end
  end

end

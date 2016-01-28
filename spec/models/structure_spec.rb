require "rails_helper"

describe Structure do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:structure)).to be_valid }
    it { expect(FactoryGirl.build(:structure, :generic)).to be_valid }
  end

  describe "elements_to_export" do
    context "with an account with a generic structure" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:structure) { FactoryGirl.create(:structure, :generic, account_id: account.id) }

      it { expect(Structure.export_filename(account)).to eq("structures-#{account.domain}.csv") }
      it { expect(Structure.elements_to_export(account)).to eq([structure]) }
    end
  end

  describe "to_csv" do
    context "with a generic structure" do
      let(:structure) { FactoryGirl.create(:structure, :generic) }

      let(:expected_line) {[structure.to_s, ExportTools.build_list(structure.emails), ExportTools.build_list(structure.phones), ExportTools.build_list(structure.addresses), ExportTools.build_list(structure.websites), structure.network_list, structure.custom_list, structure.remark, ExportTools.build_list(structure.people)
      ].to_csv}

      it { expect(structure.to_csv).to eq(expected_line) }
    end
    context "with a venue" do
      let(:venue) { FactoryGirl.create(:venue) }
      let(:structure) { venue.structure }
      let(:expected_line) {[structure.to_s, ExportTools.build_list(structure.emails), ExportTools.build_list(structure.phones), ExportTools.build_list(structure.addresses), ExportTools.build_list(structure.websites), structure.network_list, structure.custom_list, structure.remark, ExportTools.build_list(structure.people)
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

require 'rails_helper'

describe Person do

  it { expect(FactoryGirl.build(:person)).to be_valid }

  describe "export" do

    context "with an account with a person" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:henri) { FactoryGirl.create(:person, account_id: account.id) }

      it { expect(File.basename(Person.export(account))).to eq("personnes-#{account.domain}.csv") }

      it { expect(File.readlines(Person.export(account)).sort).to eq([henri.to_csv, Person.csv_header].sort) }

    end

    context "with an account with 2 people" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:henri) { FactoryGirl.create(:person, account_id: account.id) }
      let!(:george) { FactoryGirl.create(:person, account_id: account.id) }

      it { expect(File.readlines(Person.export(account)).sort).to eq([henri.to_csv, george.to_csv, Person.csv_header].sort) }
    end

  end

  describe "to_csv" do
    context "with a person" do
      let(:henri) { FactoryGirl.create(:person) }

      let(:expected_line) {[
        henri.name, ExportTools.build_list(henri.emails), ExportTools.build_list(henri.phones),
        ExportTools.build_list(henri.addresses), ExportTools.build_list(henri.websites),
        henri.network_list, henri.custom_list, henri.remark, ExportTools.build_list(henri.structures)
      ].to_csv}

      it { expect(henri.to_csv).to eq(expected_line) }
    end
  end

  describe "to_s" do
    let(:person) { FactoryGirl.create(:person, first_name: 'Jean', last_name: 'Bon') }

    it { expect(person.to_s).to eq('Jean Bon') }
  end
end

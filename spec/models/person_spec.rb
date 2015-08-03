require 'rails_helper'

describe Person do

  it { expect(FactoryGirl.build(:person)).to be_valid }

  describe "export" do

    context "with an account with a person" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:henri) { FactoryGirl.create(:person, account_id: account.id) }

      it { expect(File.basename(Person.export(account))).to eq("personnes-#{account.domain}.csv") }

      it { expect(File.readlines(Person.export(account)).sort).to eq(["#{henri.to_csv}\n", "#{Person.csv_header}\n"].sort) }

    end

    context "with an account with 2 people" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:henri) { FactoryGirl.create(:person, account_id: account.id) }
      let!(:george) { FactoryGirl.create(:person, account_id: account.id) }

      it { expect(File.readlines(Person.export(account)).sort).to eq(["#{henri.to_csv}\n", "#{george.to_csv}\n", "#{Person.csv_header}\n"].sort) }
    end

  end

  describe "to_csv" do
    context "with a person" do
      let(:henri) { FactoryGirl.create(:person) }

      let(:expected_line) {[
        henri.name, henri.email, henri.phone,
        henri.street, henri.postal_code, henri.city,
        henri.country, henri.website, henri.network_tags,
        henri.custom_tags, henri.remark
      ].join(',')}

      it { expect(henri.to_csv).to eq(expected_line) }
    end
  end
end

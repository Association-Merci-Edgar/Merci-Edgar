require 'rails_helper'

describe Person do

  it { expect(FactoryGirl.build(:person)).to be_valid }

  describe "export" do

    context "with an account with a person" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:henri) { FactoryGirl.create(:person, account_id: account.id) }

      it { expect(File.basename(Person.export(account))).to eq("personnes-#{account.domain}.csv") }

      it { expect(File.read(Person.export(account))).to eq("#{henri.to_csv}\n") }

    end

    context "with an account with 2 people" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:henri) { FactoryGirl.create(:person, account_id: account.id) }
      let!(:george) { FactoryGirl.create(:person, account_id: account.id) }

      it { expect(File.readlines(Person.export(account)).sort).to eq(["#{henri.to_csv}\n", "#{george.to_csv}\n"].sort) }
    end

  end

  describe "to_csv" do
    context "with a person" do
      let(:henri) { FactoryGirl.create(:person) }

      it { expect(henri.to_csv).to eq("#{henri.last_name},#{henri.first_name}") }
    end
  end
end

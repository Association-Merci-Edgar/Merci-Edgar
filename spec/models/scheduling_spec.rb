require "rails_helper"

describe Scheduling do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:scheduling)).to be_valid }
  end

  describe "export" do
    context "with an account with a scheduling" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:buyer) { FactoryGirl.create(:show_buyer, account_id: account.id) }
      let!(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: buyer) }

    it { expect(File.basename(Scheduling.export(account))).to eq("festivals-et-autres-organisateurs-de-spectacles-#{account.domain}.csv") }

    it { expect(File.readlines(Scheduling.export(account)).sort).to eq([scheduling.to_csv, Scheduling.csv_header].sort) }
    end
  end

  describe "to_csv" do
    context "with a show buyer only" do
      let(:buyer) { FactoryGirl.create(:show_buyer) }
      let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: buyer, show_host: nil) }

      let(:expected_line) {[
        scheduling.name, scheduling.period, scheduling.prospecting_months, scheduling.contract_list, scheduling.style_list, scheduling.remark, scheduling.discovery, buyer.name, ExportTools.build_list(buyer.emails), ExportTools.build_list(buyer.phones), ExportTools.build_list(buyer.addresses), ExportTools.build_list(buyer.websites), buyer.network_list,buyer.custom_list, buyer.remark, ExportTools.build_list(buyer.people)
      ].to_csv}

      it { expect(scheduling.to_csv).to eq(expected_line) }
    end
  end

  describe "Oranizer" do
    context "with a show buyer only" do
      let(:buyer) { FactoryGirl.create(:show_buyer) }
      let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: buyer, show_host: nil) }

      it { expect(scheduling.organizer).to eq(buyer) }
    end

    context "with a show host only" do
      let(:host) { FactoryGirl.create(:venue) }
      let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: nil, show_host: host) }

      it { expect(scheduling.organizer).to eq(host) }
    end

    context "with a show host and a show buyer" do
      let(:buyer) { FactoryGirl.create(:show_buyer) }
      let(:host) { FactoryGirl.create(:venue) }
      let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: buyer, show_host: host) }

      it { expect(scheduling.organizer).to eq(buyer) }
    end
  end
end

require "rails_helper"

describe Scheduling do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:scheduling)).to be_valid }
  end

  describe "full_name" do
    context "with a show buyer only" do
      let(:buyer) { FactoryGirl.build(:show_buyer) }
      let(:scheduling) { FactoryGirl.build(:scheduling, show_buyer: buyer )}
      it { expect(scheduling.full_name).to eq("#{scheduling.name} (#{buyer.name} [#{ShowBuyer.model_name.human}])") }
    end

    context "with a festival only" do
      let(:festival) { FactoryGirl.build(:festival) }
      let(:scheduling) { FactoryGirl.build(:scheduling, show_host: festival )}
      it { expect(scheduling.full_name).to eq("#{scheduling.name} (#{festival.name} [#{Festival.model_name.human}])") }
    end

    context "with a venue only" do
      let(:venue) { FactoryGirl.build(:venue) }
      let(:scheduling) { FactoryGirl.build(:scheduling, show_host: venue )}
      it { expect(scheduling.full_name).to eq("#{scheduling.name} (#{venue.name} [#{Venue.model_name.human}])") }
    end
    
    context "with a venue and a show buyer" do
      let(:venue) { FactoryGirl.build(:venue) }
      let(:buyer) { FactoryGirl.build(:show_buyer) }
      let(:scheduling) { FactoryGirl.build(:scheduling, show_host: venue, show_buyer: buyer )}
      it { expect(scheduling.full_name).to eq("#{scheduling.name} (#{buyer.name} [#{ShowBuyer.model_name.human}] => #{venue.name} [#{Venue.model_name.human}])") }
    end
  end
  describe "translated_period" do
    context "no specified period" do
      let(:scheduling) { FactoryGirl.build(:scheduling, period: nil)}
      it { expect(scheduling.translated_period).to eq(nil) }
    end
    
    context "with period" do
      let(:scheduling) { FactoryGirl.build(:scheduling, period: Scheduling::QUATERLY) }
      it { expect(scheduling.translated_period).to eq(I18n.t(scheduling.period, scope: 'simple_form.options.schedulings.period')) }
    end    
  end
  
  describe "export" do
    context "with an account with a scheduling" do
      let(:account) { FactoryGirl.create(:account) }
      let!(:buyer) { FactoryGirl.create(:show_buyer, account_id: account.id) }
      let!(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: buyer) }

    it { expect(File.basename(Scheduling.export(account))).to eq("programmations-#{account.domain}.csv") }

    it { expect(File.readlines(Scheduling.export(account)).sort).to eq([scheduling.to_csv, Scheduling.csv_header].sort) }
    end
  end

  describe "to_csv" do
    context "with a show buyer only" do
      let(:buyer) { FactoryGirl.create(:show_buyer) }
      
      context "with period" do
        let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: buyer, show_host: nil, period: Scheduling::QUATERLY) }

        let(:expected_line) {[
          scheduling.full_name, scheduling.scheduler_name, I18n.t(scheduling.period, scope: 'simple_form.options.schedulings.period'), scheduling.prospecting_months, scheduling.contract_list, scheduling.style_list, scheduling.remark, scheduling.discovery, "#{buyer.name} [#{ShowBuyer.model_name.human}]", ExportTools.build_list(buyer.emails), ExportTools.build_list(buyer.phones), ExportTools.build_list(buyer.addresses), ExportTools.build_list(buyer.websites), buyer.network_list,buyer.custom_list, buyer.remark, ExportTools.build_list(buyer.people)
        ].to_csv}

        it { expect(scheduling.to_csv).to eq(expected_line) }
      end
      
      context "without period" do
        let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: buyer, show_host: nil, period: nil) }

        let(:expected_line) {[
          scheduling.full_name, scheduling.scheduler_name, scheduling.period, scheduling.prospecting_months, scheduling.contract_list, scheduling.style_list, scheduling.remark, scheduling.discovery, "#{buyer.name} [#{ShowBuyer.model_name.human}]", ExportTools.build_list(buyer.emails), ExportTools.build_list(buyer.phones), ExportTools.build_list(buyer.addresses), ExportTools.build_list(buyer.websites), buyer.network_list,buyer.custom_list, buyer.remark, ExportTools.build_list(buyer.people)
        ].to_csv}

        it { expect(scheduling.to_csv).to eq(expected_line) }
      end
      
    end
    
    context "with a festival only" do
      let(:festival) { FactoryGirl.create(:festival, nb_edition: 2, last_year: '1999')}
      let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: nil, show_host: festival) }
      
      let(:expected_line) {[
        scheduling.full_name, scheduling.scheduler_name, I18n.t(scheduling.period, scope: 'simple_form.options.schedulings.period'), scheduling.prospecting_months, scheduling.contract_list, scheduling.style_list, 
        "Nb edition : 2 / Derniere annee : 1999", 
        scheduling.discovery, "#{festival.name} [#{Festival.model_name.human}]", ExportTools.build_list(festival.emails), ExportTools.build_list(festival.phones), 
        ExportTools.build_list(festival.addresses), ExportTools.build_list(festival.websites), festival.network_list,festival.custom_list, 
        festival.remark, ExportTools.build_list(festival.people)
      ].to_csv} 
      
      it { expect(scheduling.organizer).to respond_to(:nb_edition) }
      it { expect(scheduling.to_csv).to eq(expected_line) }
    end        
  end

  describe "Organizer" do
    context "with a show buyer only" do
      let(:buyer) { FactoryGirl.create(:show_buyer) }
      let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: buyer, show_host: nil) }

      it { expect(scheduling.organizer).to eq(buyer) }
      it { expect(scheduling.organizer_name).to eq("#{buyer.name} [#{ShowBuyer.model_name.human}]")}      
    end

    context "with a show host only" do
      let(:host) { FactoryGirl.create(:venue) }
      let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: nil, show_host: host) }

      it { expect(scheduling.organizer).to eq(host) }
      it { expect(scheduling.organizer_name).to eq("#{host.name} [#{host.class.model_name.human}]")}      
    end

    context "with a show host and a show buyer" do
      let(:buyer) { FactoryGirl.create(:show_buyer) }
      let(:host) { FactoryGirl.create(:venue) }
      let(:scheduling) { FactoryGirl.create(:scheduling, show_buyer: buyer, show_host: host) }

      it { expect(scheduling.organizer).to eq(buyer) }
      it { expect(scheduling.organizer_name).to eq("#{buyer.name} [#{ShowBuyer.model_name.human}]")}      
      
    end
  end

  describe "style_list for a ... " do
    context "festival" do
      let!(:festival) { FactoryGirl.create(:festival) }
      let!(:first_scheduling) { FactoryGirl.create(:scheduling, show_host: festival, style_list: ['truc', 'muche'])}
      let!(:second_scheduling) { FactoryGirl.create(:scheduling, show_host: festival, style_list: ['bidule', 'truc'])}

      it { expect(Scheduling.style_for(festival.reload).sort).to eq(['bidule', 'muche', 'truc'].sort) }
    end

    context "venue" do
      let!(:venue) { FactoryGirl.create(:venue) }
      let!(:first_scheduling) { FactoryGirl.create(:scheduling, show_host: venue, style_list: ['truc', 'muche'])}
      let!(:second_scheduling) { FactoryGirl.create(:scheduling, show_host: venue, style_list: ['bidule', 'truc'])}

      it { expect(Scheduling.style_for(venue.reload).sort).to eq(['bidule', 'muche', 'truc'].sort) }
    end

    context "show_buyer" do
      let!(:show_buyer) { FactoryGirl.create(:show_buyer) }
      let!(:first_scheduling) { FactoryGirl.create(:scheduling, show_buyer: show_buyer, style_list: ['truc', 'muche'])}
      let!(:second_scheduling) { FactoryGirl.create(:scheduling, show_buyer: show_buyer, style_list: ['bidule', 'truc'])}

      it { expect(Scheduling.style_for(show_buyer.reload).sort).to eq(['bidule', 'muche', 'truc'].sort) }
    end

  end
end

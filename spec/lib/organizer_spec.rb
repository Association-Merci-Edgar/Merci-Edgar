require 'rails_helper'

describe "Organizer" do
  describe "name_with_kind" do
    context "for a show buyer" do
      let(:buyer) { FactoryGirl.build(:show_buyer) }
      it { expect(buyer.name_with_kind).to eq("#{buyer.name} [#{ShowBuyer.model_name.human}]") }
    end
    
    context "for a festival" do
      let(:festival) { FactoryGirl.build(:festival) }
      it { expect(festival.name_with_kind).to eq("#{festival.name} [#{Festival.model_name.human}]") }
    end

    context "for a venue" do
      let(:venue) { FactoryGirl.build(:venue) }
      it { expect(venue.name_with_kind).to eq("#{venue.name} [#{Venue.model_name.human}]") }
    end
    
  end
  
end
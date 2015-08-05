require "rails_helper"

describe Phone do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:phone)).to be_valid }
  end

  describe "to_s" do
    let(:phone) { FactoryGirl.build(:phone, kind: Phone::PERSO, number: '01 30 40 50 60') }
    it { expect(phone.to_s).to eq("01 30 40 50 60 [#{Phone::PERSO}]") }
  end
end

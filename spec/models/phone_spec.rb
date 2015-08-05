require "rails_helper"

describe Phone do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:phone)).to be_valid }
  end

  describe "to_s" do
    let(:phone) { FactoryGirl.build(:phone, kind: Phone::PERSO, number: 'crotte') }
    it { expect(phone.to_s).to eq("crotte [#{Phone::PERSO}]") }
  end
end

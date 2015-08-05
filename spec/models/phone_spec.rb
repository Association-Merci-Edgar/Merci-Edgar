require "rails_helper"

describe Phone do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:phone)).to be_valid }
  end

  describe "to_s" do
    let(:phone) { FactoryGirl.build(:phone, kind: Phone::RECEPTION, number: '01 30 40 50 60') }
    it { expect(phone.to_s).to eq("01 30 40 50 60 [#{I18n.t(Phone::RECEPTION, scope: 'simple_form.options.phones.classic_kind') }]") }
  end
end

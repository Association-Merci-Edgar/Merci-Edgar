require "rails_helper"

describe Email do

  describe "have validations and a valid factory" do
    it { expect(FactoryGirl.build(:email)).to be_valid }
  end

  describe "to_s" do
    let(:email) { FactoryGirl.build(:email, address: 'stephane@laposte.net', kind: Email::PERSO) }
    it { expect(email.to_s).to eq("stephane@laposte.net [#{Email::PERSO}]") }
  end
end

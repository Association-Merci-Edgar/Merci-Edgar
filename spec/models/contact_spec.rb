require 'rails_helper'

describe Contact do

  it { expect(FactoryGirl.build(:contact)).to be_valid }

  context "with a contact" do
    let(:contact) { FactoryGirl.build(:contact) }

    describe "delete_after_store" do
      context "with a phone" do
        let(:phone) { contact.phones.build(number: '12 xx xx') }
        before(:each) { contact.delete_after_store!(phone) }
        it { expect(contact.remark).to eq("\nTel: #{phone.number} /") }
        it { expect(contact.phones).to eq([]) }
      end

      context "with an email" do
        let(:email) { contact.emails.build(address: 'trucucu') }
        before(:each) { contact.delete_after_store!(email) }
        it { expect(contact.remark).to eq("\nEmail: #{email.address} /") }
        it { expect(contact.emails).to eq([]) }
      end

      context "with an website" do
        let(:website) { contact.websites.build(url: 'http://mywebsite.com') }
        before(:each) { contact.delete_after_store!(website) }
        it { expect(contact.remark).to eq("\nSite: #{website.url} /") }
        it { expect(contact.websites).to eq([]) }
      end
    end

    describe "assign_from_csv" do
      it { expect(contact.assign_from_csv({})).to eq([]) }
      it { expect(contact.assign_from_csv({tel: '12 23 xx 45 56'})).to eq([]) }
    end
  end
end

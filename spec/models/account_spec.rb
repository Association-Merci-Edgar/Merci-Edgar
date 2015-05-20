require 'rails_helper'

describe Account do

  it { expect(FactoryGirl.build(:account)).to be_valid }

  describe :destroy_test_contacts do
    let(:date) { DateTime.new(2014,3,23) }
    let(:account) { FactoryGirl.create(:account, test_imported_at: date) }
    it { expect(account.contacts.count).to eq(0) }

    context "with a contact" do
      let!(:contact) { FactoryGirl.create(:contact, imported_at: date, account: account)}
      let!(:person) { FactoryGirl.create(:person, account_id: account.id, contact: contact)}

      before(:each) do
        Account.current_id = account
      end

      it { expect(account.contacts.count).to eq(1) }
      it { expect(account.contacts.first).to eq(contact) }
      it { expect(account.contacts.first.contactable).to eq(person) }

      it "works" do
        account.destroy_test_contacts
        expect(account.reload.contacts.count).to eq(0)
      end
    end
  end

end

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

    context "with a contact that not from last import but an other on date" do
      let(:date) { DateTime.new(2014,3,23, 10, 22) }
      let(:later_date) { DateTime.new(2014,3,23, 14, 52) }
      let!(:contact) { FactoryGirl.create(:contact, imported_at: date, account: account)}
      let!(:contact_to_remove) { FactoryGirl.create(:contact, imported_at: later_date, account: account)}

      let!(:person) { FactoryGirl.create(:person, account_id: account.id, contact: contact)}
      let!(:other_person) { FactoryGirl.create(:person, account_id: account.id, contact: contact_to_remove)}

      let(:account) { FactoryGirl.create(:account, test_imported_at: later_date) }
      before(:each) do
        Account.current_id = account
      end

      it { expect(account.contacts.count).to eq(2) }
      it { expect(account.contacts.sort).to eq([contact, contact_to_remove].sort) }
      it { expect(account.contacts.map(&:contactable).sort).to eq([person, other_person].sort) }

      it "works" do
        account.destroy_test_contacts
        expect(account.reload.contacts.count).to eq(1)
        expect(account.reload.contacts).to eq([contact])
      end
    end
  end

end

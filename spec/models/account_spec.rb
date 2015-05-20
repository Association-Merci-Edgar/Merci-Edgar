require 'rails_helper'

describe Account do

  it { expect(FactoryGirl.build(:account)).to be_valid }


  describe :destroy_test_contacts do
    let(:account) { FactoryGirl.create(:account) }
    it { expect(account.contacts.count).to eq(0) }

    context "with a contact" do
      before(:each) {Account.current_id = account}
      let!(:contact) { FactoryGirl.create(:contact, account: account)}
      it { expect(account.reload.contacts.count).to eq(1) }
    end
  end

end

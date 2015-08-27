require "rails_helper"

describe ExportContacts do

  describe "perform" do
    context "with an account" do
      let(:account) { FactoryGirl.create(:account) }
      let(:user) { FactoryGirl.create(:user) }

      it { expect {
        ExportContacts.perform_async(account.id, user.id)
      }.not_to raise_error }
    end
  end

end

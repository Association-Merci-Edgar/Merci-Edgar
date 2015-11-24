require 'rails_helper'

describe ContactsExportsController do
  let(:account) { FactoryGirl.create(:account) }
  let(:user) { FactoryGirl.create(:user, account: account) }

  before(:each) do
    @request.host = "#{account.domain}.lvh.me"
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
    Account.current_id = account.id
  end

  context "with a logged user" do
    let!(:person) { FactoryGirl.create(:person) }

    describe "GET new" do
      before(:each) { 
        ExportContacts.stubs(:perform_async).returns(true)
        get :new 
      }

      it { expect(response).to redirect_to(edit_account_path) }
      it { expect(flash[:notice]).to eq(I18n.t("notices.contacts_export.initiated")) }
    end

  end
end

require 'rails_helper'

describe ContactsExportsController do
  let(:account) { FactoryGirl.create(:account) }
  before(:each) { Account.current_id = account.id }

  context "with a logged user" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }

    let!(:person) { FactoryGirl.create(:person, account_id: account.id) }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET new" do
      before(:each) { get :new }
      it { expect(response).to redirect_to(contacts_path) }
      it { expect(flash[:notice]).to eq(I18n.t("notices.contacts_export.initiated")) }
    end

  end
end

require 'rails_helper'

describe ContactsExportsController do
  before(:each) do
    @request.host = "#{user.accounts.first.domain}.lvh.me"
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  context "with a logged user" do
    let(:user) { FactoryGirl.create(:user, label_name: "truc") }

    let!(:person) { 
      Account.current_id = user.accounts.first.id
      FactoryGirl.create(:person, account_id: user.accounts.first.id) }

    describe "GET new" do
      before(:each) { get :new }
      it { expect(response).to redirect_to(edit_account_path) }
      it { expect(flash[:notice]).to eq(I18n.t("notices.contacts_export.initiated")) }
    end

  end
end

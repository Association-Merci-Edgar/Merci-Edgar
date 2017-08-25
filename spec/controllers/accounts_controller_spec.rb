require 'rails_helper'

describe AccountsController do
  describe "GET 'edit'" do

    it "works well with a manager with the account assigns" do
      account = FactoryGirl.create(:account)
      manager = FactoryGirl.create(:user, account: account, manager: true)
      @request.host = "#{account.domain}.lvh.me"
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in manager

      get :edit

      expect(response).to be_success
      expect(assigns(:account)).to eq(account)
    end

  end
end

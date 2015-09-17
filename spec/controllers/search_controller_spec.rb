require 'rails_helper'

describe SearchController do

  context "with a logged user" do

    let(:account) { FactoryGirl.create(:account) }
    let(:user) { FactoryGirl.create(:user, account: account) }

    before(:each) do
      @request.host = "#{account.domain}.lvh.me"
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    context "with an existing project" do
      describe "GET 'index'" do
        before(:each) { get :index }
        it { expect(response).to be_success }
      end
    end
  end
end

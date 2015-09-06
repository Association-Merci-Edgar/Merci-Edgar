require 'rails_helper'

describe SearchController do

  context "with a logged user" do

    let(:user) { FactoryGirl.create(:user, label_name: "truc") }

    before(:each) do
      @request.host = "#{user.accounts.first.domain}.lvh.me"
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

require 'rails_helper'

describe SubscriptionsController do
  context "with a logged admin user" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET new" do
      before(:each) { 
        get 'new' 
      }
      it { expect(response).to be_success }
    end
    
    describe "GET edit" do
      before(:each) { 
        get 'edit' 
      }
      it { expect(response).to be_success }
    end
    
  end
end
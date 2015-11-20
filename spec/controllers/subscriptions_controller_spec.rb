require 'rails_helper'

describe SubscriptionsController do
  context "with a logged admin user" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @request.env['HTTPS'] = 'on'
      sign_in user
    end

    describe "GET new" do
      context "with http protocol" do
        before(:each) { 
          @request.env['HTTPS'] = 'off'
          get 'new' 
        }
        it { expect(response).not_to be_success }
      end

      context "with https protocol" do
        before(:each) { 
          get 'new' 
        }
        it { expect(response).to be_success }
      end
    end
    
    describe "GET edit" do
      before(:each) { 
        get 'edit' 
      }
      it { expect(response).to be_success }
    end

  end
end

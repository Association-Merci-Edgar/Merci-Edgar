require 'rails_helper'

describe HomeController do

  context "with a logged admin user" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET index" do
      before(:each) { 
        Account.current_id = user.accounts.first.id 
        get 'index' 
      }
      it { expect(response).to redirect_to(welcome_path) }
    end
  end

  context "with a logged  user that never see welcome" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET index" do
      let!(:pending_task) { FactoryGirl.create(:task) }
      before(:each) { 
        Account.current_id = user.accounts.first.id 
        get 'index' 
      }
      it { expect(response).to redirect_to(welcome_path) }
    end
  end

  context "with a logged  user that already seen welcome" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc", welcome_hidden: true) }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET index" do
      let!(:pending_task) { FactoryGirl.create(:task) }
      # TODO WHY WE NEED THIS EMPTY PARAMS ?????
      before(:each) { 
        Account.current_id = user.accounts.first.id 
        get 'index', empty: 1
      }
      it { expect(response).to be_success }
    end
  end

  context "with a logged  user with an account with subscription lasts soon" do
    let(:user) { FactoryGirl.create(:admin, with_account_subscription_lasts_soon: true, label_name: "truc") }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET index" do
      let!(:pending_task) { FactoryGirl.create(:task) }
      before(:each) { 
        Account.current_id = user.accounts.first.id 
        get 'index' 
      }
      it { expect(response).to redirect_to(welcome_path) }
      it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.need_to_subscribe_soon', end_subscription: I18n.l(user.accounts.first.subscription_lasts_at))) }
    end
    
  end
end

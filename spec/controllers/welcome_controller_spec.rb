require 'rails_helper'

describe WelcomeController do
  context "with a logged user" do

    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET 'index'" do
      before(:each) { 
        Account.current_id = user.accounts.first.id 
        get :index 
      }
      it { expect(response).to be_success }
    end
  end
    
  context "with a logged user with account trial period expired" do
    let(:user) { FactoryGirl.create(:admin, with_trial_period_account_expired: true, label_name: "truc" ) }
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end
    describe "GET index" do
      before(:each) {
        Account.current_id = user.accounts.first.id 
        get :index 
      }
      it { expect(response).to redirect_to(new_subscription_path) }
      it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.trial_period_ended')) }
    end
  end

  context "with a logged user with account subscription not up to date" do
    let(:user) { FactoryGirl.create(:admin, with_account_subscription_up_to_date: false, label_name: "truc" ) }
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end
    describe "GET index" do
      before(:each) {
        Account.current_id = user.accounts.first.id 
        get :index 
      }
      it { expect(response).to redirect_to(new_subscription_path) }
      it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.not_up_to_date')) }
    end    
  end

  context "with a logged user with account subscription last in less than one week" do
    let(:user) { FactoryGirl.create(:admin, with_account_subscription_up_to_date: false, label_name: "truc" ) }
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end
    describe "GET index" do
      before(:each) {
        Account.current_id = user.accounts.first.id 
        get :index 
      }
      it { 
        account = user.accounts.first
        puts "------- #{account.last_subscription_at}"
        puts "------- UP TO DATE #{account.subscription_up_to_date?}"
        puts "------- TRIAL_PERIOD_ENDED   #{account.trial_period_ended?}"
        expect(response).to redirect_to(new_subscription_path) }
      it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.not_up_to_date')) }
    end    
  end

end

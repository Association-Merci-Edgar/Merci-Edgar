require 'rails_helper'

describe WelcomeController do
  before(:each) do
    @request.host = "#{user.accounts.first.domain}.lvh.me"
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
  
  context "with a logged user" do

    let(:user) { FactoryGirl.create(:user, label_name: "truc") }
    describe "GET 'index'" do
      before(:each) { get :index }
      it { expect(response).to be_success }
    end
  end
    
  context "with a logged user with account trial period expired" do
    let(:user) { FactoryGirl.create(:user, with_trial_period_account_expired: true, label_name: "truc" ) }
    describe "GET 'index'" do
      before(:each) { get :index }
      it { expect(response).to redirect_to(new_subscription_path) }
      it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.trial_period_ended')) }
    end
  end

  context "with a logged user with account subscription not up to date" do
    let(:user) { FactoryGirl.create(:user, with_account_subscription_up_to_date: false, label_name: "truc" ) }
    describe "GET 'index'" do
      before(:each) { get :index }
      it { expect(response).to redirect_to(new_subscription_path) }
      it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.not_up_to_date')) }
    end    
  end

  context "with a logged user with account subscription last in less than one week" do
    let(:user) { FactoryGirl.create(:user, with_account_subscription_up_to_date: false, label_name: "truc" ) }
    describe "GET 'index'" do
      before(:each) { get :index }
      it { expect(response).to redirect_to(new_subscription_path) }
      it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.not_up_to_date')) }
    end    
  end

end

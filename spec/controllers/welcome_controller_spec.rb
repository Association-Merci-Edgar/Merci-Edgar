require 'rails_helper'

describe WelcomeController do
  before(:each) do
    @request.host = "#{account.domain}.lvh.me"
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
  
  context "with a logged user" do
    let(:user) { FactoryGirl.create(:user, account: account) }
    describe "GET 'index'" do
      let(:account) { FactoryGirl.create(:account)}
      before(:each) { get :index }
      it { expect(response).to be_success }
    end
    
    context "with account trial period expired" do
      let!(:account) { FactoryGirl.create(:account, :with_trial_period_account_expired)}    
      describe "GET 'index'" do
        before(:each) { get :index }
        it { expect(response).to redirect_to(new_subscription_path) }
        it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.trial_period_ended')) }
      end
    end

    context "with account subscription not up to date" do
      let(:account) { FactoryGirl.create(:account, :with_account_subscription_not_up_to_date)}    
      describe "GET 'index'" do
        before(:each) { get :index }
        it { expect(response).to redirect_to(new_subscription_path) }
        it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.not_up_to_date')) }
      end    
    end
    
    context "with an account with subscription lasts soon" do
      let(:account) { FactoryGirl.create(:account, :with_account_subscription_lasts_soon) }

      describe "GET index" do
        before(:each) { get 'index' }
        it { expect(response).to be_success }
        it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.need_to_subscribe_soon_html', end_subscription: I18n.l(account.subscription_lasts_at), link: new_subscription_path)) }
      end    
    end
  end  

  context "with a logged user which is not a manager" do
    let(:user) {FactoryGirl.create(:member, account: account)}
    let!(:manager) { FactoryGirl.create(:user, account: account) }

    context "with a solo account" do
      let(:account) { FactoryGirl.create(:account, :solo_account) }
      describe "GET index" do
        before(:each) { get :index }
        it { expect(response).to redirect_to(edit_subscription_path)}
        it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.single_user_access', account_name: account.name, manager_name: manager.name)) }
      end
    end
    
    context "with a team account" do
      let(:account) { FactoryGirl.create(:account, :team_account)}
      describe "GET index" do
        before(:each) { get :index }
        it { expect(response).to be_success }
      end
    end
  end

  context "with a logged user which is the manager of a solo account" do
    let(:account) { FactoryGirl.create(:account, :solo_account) }
    let(:manager) { FactoryGirl.create(:user, account: account) }
    let(:user) { manager }
    describe "GET index" do
      before(:each) { get :index }
      it { expect(response).to be_success }
    end
  end
end
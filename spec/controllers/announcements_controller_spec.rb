require 'rails_helper'

describe AnnouncementsController do
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
    
    context "with account trial period lasts soon" do
      let!(:account) { FactoryGirl.create(:account, :with_trial_period_lasts_soon)}    
      describe "GET 'index'" do
        before(:each) { get :index }
        it { expect(assigns[:membership_warning]).to eq(
          I18n.t('notices.subscriptions.trial_period_lasts_soon_html',
            end_trial_period: I18n.l(account.trial_period_lasts_at),
            link: new_subscription_path
          )) 
        }
      end
    end

 
    context "with an account with subscription lasts soon" do
      let(:account) { FactoryGirl.create(:account, :with_account_subscription_lasts_soon) }

      describe "GET index" do
        before(:each) { get 'index' }
        it { expect(response).to be_success }
        it { expect(assigns[:membership_warning]).to eq(I18n.t('notices.subscriptions.need_to_subscribe_soon_html', end_subscription: I18n.l(account.subscription_lasts_at), link: new_subscription_path)) }
      end    
    end
  end  
end

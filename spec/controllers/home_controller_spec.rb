require 'rails_helper'

describe HomeController do
  before(:each) do
    @request.host = "#{user.accounts.first.domain}.lvh.me"
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user    
  end
  

  context "with a logged admin user" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }
    describe "GET index" do
      before(:each) { get 'index' }
      it { expect(response).to redirect_to(welcome_path) }
    end
  end

  context "with a logged  user that never see welcome" do
    let(:user) { FactoryGirl.create(:user, label_name: "truc") }

    describe "GET index" do
      let!(:pending_task) { FactoryGirl.create(:task) }
      before(:each) { get 'index' }
      it { expect(response).to redirect_to(welcome_path) }
    end
  end

  context "with a logged  user that already seen welcome" do
    let(:user) { FactoryGirl.create(:user, label_name: "truc", welcome_hidden: true) }

    describe "GET index" do
      let!(:pending_task) { FactoryGirl.create(:task) }
      # TODO WHY WE NEED THIS EMPTY PARAMS ?????
      before(:each) { get 'index', empty: 1}
      it { expect(response).to be_success }
    end
  end

  context "with a logged  user with an account with subscription lasts soon" do
    let(:user) { FactoryGirl.create(:user, with_account_subscription_lasts_soon: true, label_name: "truc") }

    describe "GET index" do
      let!(:pending_task) { FactoryGirl.create(:task) }
      before(:each) { get 'index' }
      it { expect(response).to redirect_to(welcome_path) }
      it { expect(flash[:notice]).to eq(I18n.t('notices.subscriptions.need_to_subscribe_soon_html', end_subscription: I18n.l(user.accounts.first.subscription_lasts_at), link: new_subscription_path)) }
    end    
  end
end
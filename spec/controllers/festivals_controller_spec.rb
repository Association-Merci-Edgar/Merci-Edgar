require 'rails_helper'

describe FestivalsController do
  context "with a logged user" do

    let(:account) { FactoryGirl.create(:account) }
    let(:user) { FactoryGirl.create(:user, account: account) }

    before(:each) do
      @request.host = "#{account.domain}.lvh.me"
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      Account.current_id = account.id
    end

    context "with a valid festival" do
      let!(:festival) { FactoryGirl.create(:festival) }

      describe "GET index" do
        before(:each) { get :index }
        it { expect(response).to be_success }
        it { expect(assigns(:festivals)).to eq([festival]) }
      end

      describe "GET show" do
        before(:each) { get :show, id: festival.id}
        it { expect(response).to be_success }
        it { expect(assigns(:festival)).to eq(festival) }
      end

      describe "GET edit" do
        before(:each) { get :edit, id: festival.id}
        it { expect(response).to be_success }
        it { expect(assigns(:festival)).to eq(festival) }
      end

      describe "PUT update" do
        before(:each) { put :update, id: festival.id, :festival => { "nb_edition" => "1" }}
        it { expect(response).to redirect_to(festival) }
        it { expect(assigns(:festival)).to eq(festival) }
      end

      describe "DELETE destroy" do
        before(:each) { delete :destroy, id: festival.id }
        it { expect(Festival.count).to eq(0) }
        it { expect(response).to redirect_to(festivals_url) }
      end
    end

    describe "GET new" do
      before(:each) { get :new }
      it { expect(response).to be_success }
      it { expect(assigns(:festival)).to be_a_new(Festival) }
    end

    describe "POST create" do
      before(:each) { post :create }
      it { 
        Account.current_id = account.id
        expect(Festival.count).to eq(1) 
      }
      it { expect(assigns(:festival)).to be_a(Festival) }
      it { expect(assigns(:festival)).to be_persisted }
      it { 
        Account.current_id = account.id
        expect(response).to redirect_to(Festival.last) 
      }
    end
  end
end

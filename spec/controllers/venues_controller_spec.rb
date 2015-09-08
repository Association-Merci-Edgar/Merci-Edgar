require 'rails_helper'

describe VenuesController do

  context "with a logged user" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }

    before(:each) do
      @request.host = "#{user.accounts.first.domain}.lvh.me"
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      Account.current_id = user.accounts.first.id
    end

    context "with an existing venue" do
      let!(:venue) { FactoryGirl.create(:venue) }

      describe "GET index" do
        before(:each) { get :index }
        it { expect(response).to be_success }
        it { 
          Account.current_id = user.accounts.first.id
          expect(assigns(:contacts)).to eq([venue]) }
      end

      describe "GET show" do
        before(:each) { get :show, id: venue.id }
        it { expect(response).to be_success }
        it { expect(assigns(:venue)).to eq(venue) }
      end

      describe "GET edit" do
        before(:each) { get :edit, id: venue.id }
        it { expect(response).to be_success }
        it { expect(assigns(:venue)).to eq(venue) }
      end

      describe "PUT update" do
        context "simple" do
          before(:each) { post :update, id: venue.id }
          it { expect(assigns(:venue)).to eq(venue) }
          it { expect(response).to redirect_to(venue) }
        end

        context "with a room update" do
          before(:each) do
            post :update, id: venue.id, venue: {rooms_attributes: [{name: 'Salle principale', seating: '10', standing: '30', modular_space: '0'}] }
            venue.reload
          end
          it { expect(venue.rooms.first.name).to eq('Salle principale') }
          it { expect(venue.rooms.first.seating).to eq(10) }
          it { expect(venue.rooms.first.standing).to eq(30) }
          it { expect(venue.rooms.first.modular_space).to be_falsy }
        end
      end

      describe "DELETE destroy" do
        before(:each) { delete :destroy, id: venue.id }
        it { expect(Venue.count).to eq(0) }
        it { expect(response).to redirect_to(venues_url) }
      end
    end

    describe "GET new" do
      before(:each) { get :new }
      it { expect(response).to be_success }
      it { expect(assigns(:venue)).to be_a_new(Venue) }
    end

    describe "POST create" do
      before(:each) { post :create, venue: {} }
      it { expect(Venue.where(account_id:user.accounts.first.id).count).to eq(1) }
      it { expect(assigns(:venue)).to be_a(Venue) }
      it { expect(assigns(:venue)).to be_persisted }
      it { 
        Account.current_id = user.accounts.first.id
        expect(response).to redirect_to(edit_venue_path(Venue.last)) }
    end
  end
end

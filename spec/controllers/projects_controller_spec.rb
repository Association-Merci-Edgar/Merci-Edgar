require 'rails_helper'

describe ProjectsController do

  context "with a logged user" do

    let(:account) { FactoryGirl.create(:account) }
    let(:user) { FactoryGirl.create(:user, account: account) }

    before(:each) do
      @request.host = "#{account.domain}.lvh.me"
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      Account.current_id = account.id
    end

    context "with an existing project" do
      let!(:project) { FactoryGirl.create(:project) }

      describe "GET index" do
        before(:each) { get :index }
        it { expect(response).to be_success }
        it { expect(assigns(:projects)).to eq([project]) }
      end

      describe "GET show" do
        before(:each) { get :show, id: project.id }
        it { expect(response).to be_success }
        it { expect(assigns(:project)).to eq(project) }
      end

      describe "GET edit" do
        before(:each) { get :edit, id: project.id }
        it { expect(response).to be_success }
        it { expect(assigns(:project)).to eq(project) }
      end

      describe "PUT update" do
        before(:each) { post :update, id: project.id, project: { description: "a new description"} }
        it { expect(assigns(:project)).to eq(project) }
        it { expect(response).to redirect_to(projects_path) }
      end

      describe "DELETE destroy" do
        before(:each) { delete :destroy, id: project.id }
        it { expect(response).to redirect_to(projects_url) }
        it { expect(Project.count).to eq(0) }
      end
    end

    describe "GET new" do
      before(:each) { get :new }
      it { expect(response).to be_success }
      it { expect(assigns(:project)).to be_a_new(Project) }
    end

    describe "POST create" do
      before(:each) { post :create, project: FactoryGirl.attributes_for(:project) }
      it { expect(response).to redirect_to(projects_path) }
      it { 
        Account.current_id = account.id
        expect(Project.count).to eq(1) 
      }
      it { expect(assigns(:project)).to be_a(Project) }
      it { expect(assigns(:project)).to be_persisted }
    end
  end
end

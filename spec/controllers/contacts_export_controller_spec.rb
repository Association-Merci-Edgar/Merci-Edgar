require 'rails_helper'

describe ContactsExportsController do
  context "with a logged user" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET new" do
      before(:each) { get :new }
      it { expect(response).to be_success }
      it { expect(response.header["Content-Type"]).to eq('application/zip') }
    end

  end
end

require 'rails_helper'

describe ContactsController do
  context "with a logged user" do
    let(:user) { FactoryGirl.create(:admin, label_name: "truc") }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    describe "GET 'index'" do
      before(:each) { get 'index' }
      it { expect(response).to be_success }
    end

    describe "GET 'autocomplete'" do
      before(:each) { get 'autocomplete', term: 'bac' }
      it { expect(Contact.count).to eq(0)}
      it { expect(response).to be_success }
      it { expect(response.body).to eq([{value:"bac",label:"Cr\u00e9er la structure : bac", new:"true",link:"/fr/structures/new?name=bac"},{value:"bac",label:"Cr\u00e9er la personne : bac",new:"true",link:"/fr/people/new?name=bac"}].to_json) }
    end


  end
end

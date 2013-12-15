require "spec_helper"

describe OpportunitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/opportunities").should route_to("opportunities#index")
    end

    it "routes to #new" do
      get("/opportunities/new").should route_to("opportunities#new")
    end

    it "routes to #show" do
      get("/opportunities/1").should route_to("opportunities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/opportunities/1/edit").should route_to("opportunities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/opportunities").should route_to("opportunities#create")
    end

    it "routes to #update" do
      put("/opportunities/1").should route_to("opportunities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/opportunities/1").should route_to("opportunities#destroy", :id => "1")
    end

  end
end

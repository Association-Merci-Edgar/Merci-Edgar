require "rails_helper"

describe OpportunitiesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/opportunities")).to route_to("opportunities#index")
    end

    it "routes to #new" do
      expect(get("/opportunities/new")).to route_to("opportunities#new")
    end

    it "routes to #show" do
      expect(get("/opportunities/1")).to route_to("opportunities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/opportunities/1/edit")).to route_to("opportunities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/opportunities")).to route_to("opportunities#create")
    end

    it "routes to #update" do
      expect(put("/opportunities/1")).to route_to("opportunities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/opportunities/1")).to route_to("opportunities#destroy", :id => "1")
    end

  end
end

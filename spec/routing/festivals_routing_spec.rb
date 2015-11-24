require "spec_helper"

describe FestivalsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/festivals")).to route_to("festivals#index")
    end

    it "routes to #new" do
      expect(get("/festivals/new")).to route_to("festivals#new")
    end

    it "routes to #show" do
      expect(get("/festivals/1")).to route_to("festivals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/festivals/1/edit")).to route_to("festivals#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/festivals")).to route_to("festivals#create")
    end

    it "routes to #update" do
      expect(put("/festivals/1")).to route_to("festivals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/festivals/1")).to route_to("festivals#destroy", :id => "1")
    end

  end
end

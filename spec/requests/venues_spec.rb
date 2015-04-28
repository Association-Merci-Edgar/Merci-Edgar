require 'rails_helper'

describe "Venues" do
  describe "GET /venues" do
    it "works! (now write some real specs)" do
      get venues_path
      response.status.should be(200)
    end
  end
end

require 'rails_helper'

describe "Venues" do
  context "without a logged user" do
    describe "GET /venues" do
      it "works! (now write some real specs)" do
        get venues_path
        response.status.should be(302)
      end
    end
  end
end

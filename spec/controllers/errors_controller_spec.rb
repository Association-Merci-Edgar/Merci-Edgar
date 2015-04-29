require 'rails_helper'

describe ErrorsController do

  describe "GET 'routing'" do
    it "returns http success" do
      get 'routing'
      response.should be_not_found
    end
  end

end

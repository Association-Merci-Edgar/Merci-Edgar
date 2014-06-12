shared_examples "the contact" do
  it "should have the correct email address" do
    contact.email_address.should == "contact@example.com"
  end
  
  it "should have the correct website url" do
    contact.website_url.should == "http://www.example.com"
  end
  
  it "should have the correct phone number" do
    contact.phone_number.should == "+33 1 60 37 69 83"
  end
  
  it "should have the correct street" do
    contact.address.street.should == "1 impasse du Cottage"
  end
  
  it "should have the correct country" do
    contact.address.country.should == "FR"
  end
  
  it "should have the correct postal code" do
    contact.address.postal_code.should == "77200"
  end
  
end

shared_examples "the contact with invalid key" do
  it "should have the key in remark field" do
    contact.remark.should include(invalid_value)
    contact[invalid_key].should be_nil
  end
end
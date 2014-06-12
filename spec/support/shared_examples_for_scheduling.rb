shared_examples "a scheduling" do
  it "should have the correct styles" do
    scheduling.style_tags.should == "reggae,fusion"
  end
  
  it "should have the correct contracts" do
    scheduling.contract_tags.should == "Cession"
  end
  
  it "should have the correct discovery flag" do
    scheduling.discovery.should be_true
  end
  
  it "should have the correct remark" do
    scheduling.remark.should == "Très pointu"
  end
  it "should have the correct prospecting months" do
    scheduling.prospecting_months.should == ["1","2","3","9","10","11"]
  end
  it "should have the correct scheduler" do
    scheduling.scheduler_id.should be Person.where(first_name: "Jean-Pierre", last_name: "Dusse").first.id
  end
end
shared_examples "a structure with people" do
  let(:scheduler) { Person.where(first_name: "Jean-Pierre", last_name: "Dusse").first }
  let(:regisseur) { Person.where(first_name: "Yvan", last_name: "Trop").first }

  it "should have the correct people" do
    structure.people.should include(scheduler, regisseur)
  end
  
  it "should have people with correct functions" do
    ps_scheduler = structure.people_structures.where(person_id: scheduler.id).first
    # ps_regisseur = structure.people_structures.where(person_id: regisseur.id).first
    ps_scheduler.title.should == "Programmateur"
    # ps_regisseur.title.should == "Regisseur"
    # regisseur.contact.phone_number.should == "+33 1 02 03 04 05"
    # regisseur.contact.email_address.should == "yvan@trop.com"
    scheduler.contact.email_address.should == "jp@festochereggae.com"
    # scheduler.contact.website_url.should == "http://www.jpdusse.com"
    
  end
=begin  
  describe "people should have correct attributes" do
    it "should blabla" do
      structure.people.each do |p|
        it_behaves_like "the contact" do
          let(:contact) { p.contact}
        end
      end
    end
  end
=end
end
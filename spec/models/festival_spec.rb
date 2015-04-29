require 'rails_helper'

describe Festival do
  describe "csv import" do
    let(:row) { merge_attributes(:festival_attributes, :contact_attributes, :scheduling_attributes, :people_structure_attributes) }
    subject { get_model(Festival, row) }

    it { should == 2 }
    it { should == 2013 }
    it { should == "Festoche Reggae"}

    it_behaves_like "the contact" do
      let(:contact) { subject.contact }
    end

    it_behaves_like "a scheduling" do
      let(:scheduling) { subject.schedulings.first }
    end

    it_behaves_like "a structure with people" do
      let!(:structure) { subject.structure }
    end

    it "should create a festival with # for festival with same name" do
      f = Festival.new
      f.build_structure.build_contact
      f.structure.contact.name = "Festoche Genial"
      f.save!
 
      f2 = get_model(Festival, row, nom: "festoche genial")
      f2.name.should == "Festoche Genial #1"
      Festival.count.should == 2
    end

    it "should create a person with # for person with same name" do
      p = Person.new
      p.name = "Dusse Jean-Pierre"
      p.save!
      
      p2 = Person.new
      p2.name = "Trop Yvan"
      p2.save!
 
      f = get_model(Festival, row, nom: "festoche genial")
      p.contact.has_duplicates?.should be_true
      p2.contact.has_duplicates?.should be_true
    end    
        
    context "with invalid keys" do
      describe "with invalid email" do
        subject { get_model(Festival, row, email: "toto") }

        it_behaves_like "the contact with invalid key" do
          let(:contact) { subject.contact }
          let(:invalid_key) { :email_address }
          let(:invalid_value) { "toto" }
        end
      end
      describe "with name and unknown keys" do
        unknown_columns = { email2: "toto@toto.com", city2: "Choisy" }
        row = {nom:"Mon festoche"}.merge(unknown_columns)
        subject { get_model(Festival, row) }

        unknown_columns.each do |k,v|
          it_behaves_like "the contact with invalid key" do
            let(:contact) { subject.contact }
            let(:invalid_key) { k }
            let(:invalid_value) { v }
          end
        end
      end

    end
  end
end

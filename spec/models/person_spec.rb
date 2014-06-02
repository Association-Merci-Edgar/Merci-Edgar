require 'spec_helper'

describe Person do
  
  describe "csv import" do
    let(:row) { merge_attributes(:person_attributes, :contact_attributes) }
    subject { get_model(Person, row) }

    its(:first_name) { should == "Jean-Pierre" }
    its(:last_name) { should == "Dusse" }
    its(:name) { should == "Dusse Jean-Pierre"}
    it_behaves_like "the contact" do
      let(:contact) { subject.contact }
    end

    context "with invalid keys" do
      describe "with invalid email" do
        subject { get_model(Person, row, email: "toto") }

        it_behaves_like "the contact with invalid key" do
          let(:contact) { subject.contact }
          let(:invalid_key) { :email_address }
          let(:invalid_value) { "toto" }
        end
      end
      describe "with name and unknown keys" do
        unknown_columns = { email2: "toto@toto.com", city2: "Choisy" }
        row = {nom:"Mon festoche"}.merge(unknown_columns)
        subject { get_model(Person, row) }

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
require "rails_helper"

describe Address do

  it "have validations and a valid factory" do
    expect(FactoryGirl.build(:address)).to be_valid
  end


  describe :full_address do
    it "return a string with all data when exist" do
      address = FactoryGirl.build(:address,
                                  street: '34 rue de la gare',
                                  city: 'Marseille',
                                  postal_code: '13003',
                                  more_info: 'près du piano, à coté du McDo',
                                  country: 'France')
      expect(address.full_address).to eq('34 rue de la gare, 13003 Marseille, France, près du piano, à coté du McDo')
    end

    it "return string only with existing data" do
      address = FactoryGirl.build(:address,
                                  street: nil,
                                  city: 'Marseille',
                                  postal_code: '13003',
                                  more_info: nil,
                                  country: 'France')
      expect(address.full_address).to eq('13003 Marseille, France')
    end
 
  end

  describe :to_s do
    it "return string based on full_address and add kind of address" do
      address = FactoryGirl.build(:address, street: '34 rue de la gare', city: 'Marseille', postal_code: '13003',
                                  more_info: 'près du piano, à coté du McDo', country: 'FR', kind: Address::MAIN_ADDRESS)
      expect(address.to_s).to eq("#{address.full_address} [Adresse principale]")
    end

    it 'return only full address without kind' do
      address = FactoryGirl.build(:address, street: '34 rue de la gare', city: 'Marseille', postal_code: '13003', 
                                  more_info: 'près du piano, à coté du McDo', country: 'FR', kind: nil)
      expect(address.to_s).to eq("#{address.full_address}")
    end
  end
end

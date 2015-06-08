require 'rails_helper'

describe ContactsImport do
  it { expect(FactoryGirl.build(:contacts_import)).to be_valid }
end


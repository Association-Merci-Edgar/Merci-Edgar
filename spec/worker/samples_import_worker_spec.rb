require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

describe 'SamplesImportWorker' do
  describe 'perform' do
    context "with an account" do
      let(:account) { FactoryGirl.create(:account) }

      it { expect {
        SamplesImportWorker.perform_async(account.id)
      }.not_to raise_error }

      it "creates 6 contacts" do  
        SamplesImportWorker.perform_async(account.id)
        expect(Contact.count).to eq(6) 
      end
    end
  end
end
require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

describe SendSubscriptionReceiptEmailWorker do
  describe "perform" do
    context "with an account" do
      let(:account) { FactoryGirl.create(:account) }
      let(:user) { FactoryGirl.create(:user) }

      it "sends a subscription receipt email" do
        expect{ SendSubscriptionReceiptEmailWorker.perform_async(account.id, user.id, 20)}
          .not_to raise_error
      end
    end
  end
end

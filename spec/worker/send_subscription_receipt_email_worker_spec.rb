require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

describe SendSubscriptionReceiptEmailWorker do
  describe "perform" do
    it { expect(SendSubscriptionReceiptEmailWorker).to respond_to(:perform_async) }
  end
end

require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

describe SendUpgradeReceiptEmailWorker do
  describe "perform" do
    it { expect(SendUpgradeReceiptEmailWorker).to respond_to(:perform_async) }
  end
end

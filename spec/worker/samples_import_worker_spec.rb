require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

describe 'SamplesImportWorker' do
  describe 'perform' do
    it { expect(SamplesImportWorker).to respond_to(:perform_async) }
  end
end

class SamplesImportWorker
  include Sidekiq::Worker

  def perform(account_id)
    Account.current_id=account_id
    logger.info { "Import samples into #{Account.current_id}"}

    account = Account.find(account_id)
    account.populate if account

  end
end
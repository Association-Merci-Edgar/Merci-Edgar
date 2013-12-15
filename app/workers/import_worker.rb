class ImportWorker
  include Sidekiq::Worker

  def perform(account_id)
    Account.current_id=account_id
    logger.info { "Import into #{Account.current_id}"}

    community = Account.find(1)
    total = community.venues.size
    i=0.0
    community.venues.each do |v|
      my_venue = v.my_dup(account_id)
      my_venue.save(validation: false)
      i += 1
      # at (i/total).round(2)*100, 100, "En cours"
    end

  end
end
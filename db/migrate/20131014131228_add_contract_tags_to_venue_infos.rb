class AddContractTagsToVenueInfos < ActiveRecord::Migration
  def change
    add_column :venue_infos, :contract_tags, :string
  end
end

class CreateVenueInfos < ActiveRecord::Migration
  def change
    create_table :venue_infos do |t|
      t.float :depth
      t.float :width
      t.float :height
      t.string :kind

      t.belongs_to :venue

      t.timestamps
    end
    add_index :venue_infos, :venue_id
  end
end

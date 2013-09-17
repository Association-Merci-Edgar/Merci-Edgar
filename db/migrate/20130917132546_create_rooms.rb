class CreateRooms < ActiveRecord::Migration
  def change
    remove_column :venue_infos, :depth, :float
    remove_column :venue_infos, :width, :float
    remove_column :venue_infos, :height, :float
    remove_column :venue_infos, :bar, :boolean
    create_table :rooms do |t|
      t.string :name
      t.float :depth
      t.float :width
      t.float :height
      t.boolean :bar
      t.belongs_to :venue

      t.timestamps
    end
    add_index :rooms, :venue_id
    remove_column :capacities, :venue_info_id, :integer
    add_column :capacities, :room_id, :integer
    add_index :capacities, :room_id
  end
end

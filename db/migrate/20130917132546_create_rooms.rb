class CreateRooms < ActiveRecord::Migration
  def up
    remove_column :venue_infos, :depth
    remove_column :venue_infos, :width
    remove_column :venue_infos, :height
    remove_column :venue_infos, :bar
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
    remove_column :capacities, :venue_info_id
    add_column :capacities, :room_id, :integer
    add_index :capacities, :room_id
  end
  def down
    add_column :venue_infos, :depth, :float
    add_column :venue_infos, :width, :float
    add_column :venue_infos, :height, :float
    add_column :venue_infos, :bar, :boolean
    drop_table :rooms
    add_column :capacities, :venue_info_id, :integer
    remove_column :capacities, :room_id
  end

end

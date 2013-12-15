class CreateCapacities < ActiveRecord::Migration
  def change
    create_table :capacities do |t|
      t.integer :nb
      t.string :kind
      t.references :venue

      t.timestamps
    end
    add_index :capacities, :venue_id
  end
end

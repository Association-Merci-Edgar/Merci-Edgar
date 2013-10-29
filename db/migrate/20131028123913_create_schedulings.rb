class CreateSchedulings < ActiveRecord::Migration
  def change
    create_table :schedulings do |t|
      t.integer :start_month
      t.integer :end_month
      t.belongs_to :venue_info

      t.timestamps
    end
    add_index :schedulings, :venue_info_id
  end
end

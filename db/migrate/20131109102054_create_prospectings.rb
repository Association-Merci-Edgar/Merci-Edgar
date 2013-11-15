class CreateProspectings < ActiveRecord::Migration

  def change
    create_table :prospectings do |t|
      t.integer :start_month
      t.integer :end_month
      t.belongs_to :scheduling
      t.timestamps
    end
    add_index :prospectings, :scheduling_id
  end

end

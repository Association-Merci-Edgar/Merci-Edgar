class CreateSchedulings < ActiveRecord::Migration
  def change
    create_table :schedulings do |t|
      t.belongs_to :show_host, polymorphic: true
      t.belongs_to :show_buyer
      t.string :period
      t.string :contract_tags

      t.timestamps
    end
    add_index :schedulings, :show_host_id
    add_index :schedulings, :show_buyer_id
  end
end

class CreateSchedulings < ActiveRecord::Migration
  def change
    create_table :schedulings do |t|
      t.belongs_to  :show_host, polymorphic: true
      t.belongs_to  :show_buyer
      t.belongs_to  :scheduler
      t.string      :period
      t.string      :contract_tags
      t.string      :style_tags

      t.timestamps
    end
    add_index :schedulings, :show_host_id
    add_index :schedulings, :show_buyer_id
    add_index :schedulings, :scheduler_id
  end
end

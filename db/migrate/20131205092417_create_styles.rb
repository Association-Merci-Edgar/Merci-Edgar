class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string  :style
      t.integer :account_id

      t.timestamps
    end
    add_index :styles, :account_id
  end
end

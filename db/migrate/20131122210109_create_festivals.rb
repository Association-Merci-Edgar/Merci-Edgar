class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.integer :nb_edition
      t.integer :last_year
      t.string  :artists_kind
      t.string  :avatar
      t.integer :account_id

      t.timestamps
    end
    add_index :festivals, :account_id
  end
end

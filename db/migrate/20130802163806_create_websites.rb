class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :url
      t.string :kind
      t.references :contact_datum

      t.timestamps
    end
    add_index :websites, :contact_datum_id
  end
end

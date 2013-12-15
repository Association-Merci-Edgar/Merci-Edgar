class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.string :kind
      t.references :contact_datum

      t.timestamps
    end
    add_index :phones, :contact_datum_id
  end
end

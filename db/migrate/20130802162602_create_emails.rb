class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :address
      t.string :kind
      t.references :contact_datum

      t.timestamps
    end
    add_index :emails, :contact_datum_id
  end
end

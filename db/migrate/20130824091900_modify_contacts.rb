class ModifyContacts < ActiveRecord::Migration
  def up
    drop_table :contacts
    drop_table :venues
    drop_table :people
    drop_table :contact_data

    rename_column :addresses, :contact_datum_id, :contact_id
    rename_column :emails, :contact_datum_id, :contact_id
    rename_column :phones, :contact_datum_id, :contact_id
    rename_column :websites, :contact_datum_id, :contact_id

    create_table :contacts do |t|
      t.string  :type
      t.string  :name

      t.string  :first_name
      # t.string  :last_name

      t.integer :account_id
      t.timestamps
    end

    add_index :contacts, :account_id
  end

  def down
    rename_column :addresses, :contact_id, :contact_datum_id
    rename_column :emails, :contact_id, :contact_datum_id
    rename_column :phones, :contact_id, :contact_datum_id
    rename_column :websites, :contact_id, :contact_datum_id

    drop_table :contacts
    create_table :contacts do |t|
      t.string :phone
      t.string :email
      t.string :website
      t.string :street
      t.string :postal_code
      t.string :state
      t.string :city
      t.string :country
      t.integer :contactable_id
      t.string :contactable_type
      t.timestamps
    end

    create_table :venues do |t|
      t.string :name
      t.integer :account_id

      t.timestamps
    end
    add_index :venues, :account_id

    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.references :account
      t.integer :structure_id
      t.string :structure_type

      t.timestamps
    end
    add_index :people, :account_id
    add_index :people, :structure_id

    create_table :contact_data do |t|
      t.integer :contactable_id
      t.string :contactable_type
      t.timestamps
    end
    add_index :contact_data, :contactable_id

  end
end

class CreateContacts < ActiveRecord::Migration
  def change
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
  end
end

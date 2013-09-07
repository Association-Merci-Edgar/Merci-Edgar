class CreateFavoriteContacts < ActiveRecord::Migration
  def change
    create_table :favorite_contacts do |t|
      t.belongs_to :user
      t.belongs_to :contact

      t.timestamps
    end
    add_index :favorite_contacts, :user_id
    add_index :favorite_contacts, :contact_id
  end
end

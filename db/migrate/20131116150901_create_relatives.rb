class CreateRelatives < ActiveRecord::Migration
  def change
    create_table :relatives do |t|
      t.belongs_to :user
      t.belongs_to :person
      t.belongs_to :structure

      t.timestamps
    end
    add_index :relatives, :user_id
    add_index :relatives, :person_id
    add_index :relatives, :structure_id
  end
end

class ModifyPeopleStructures < ActiveRecord::Migration
  def up
    drop_table :people_structures
    create_table :people_structures do |t|
      t.integer :person_id
      t.integer :structure_id
      t.string :title
    end
    # add_index :people_structures, [:person_id, :structure_id]
  end

  def down
  end
end

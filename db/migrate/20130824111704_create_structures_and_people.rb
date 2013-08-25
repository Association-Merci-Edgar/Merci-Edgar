class CreateStructuresAndPeople < ActiveRecord::Migration
  def change
    create_table :people_structures do |t|
      t.integer :structure_id
      t.integer :person_id
    end
  end

end

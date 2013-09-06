class AddStructureTypeToPeopleStructures < ActiveRecord::Migration
  def change
    add_column :people_structures, :structure_type, :string
  end
end

class AddTitleToPeopleStructures < ActiveRecord::Migration
  def change
    add_column :people_structures, :title, :string
  end
end

class AddModularToCapacities < ActiveRecord::Migration
  def change
    add_column :capacities, :modular, :boolean
  end
end

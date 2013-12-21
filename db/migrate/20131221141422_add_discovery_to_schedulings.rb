class AddDiscoveryToSchedulings < ActiveRecord::Migration
  def change
    add_column :schedulings, :discovery, :boolean
  end
end

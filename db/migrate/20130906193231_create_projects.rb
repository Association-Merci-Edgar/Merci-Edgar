class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.belongs_to :account

      t.timestamps
    end
    add_index :projects, :account_id
  end
end

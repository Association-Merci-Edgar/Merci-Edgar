class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :priority
      t.string :category
      t.boolean :specific_time
      t.datetime :due_at
      t.datetime :completed_at

      t.integer :asset_id
      t.string :asset_type
      t.integer :assigned_to
      t.integer :completed_by
      t.integer :account_id
      t.integer :user_id

      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :account_id
    add_index :tasks, :assigned_to
    add_index :tasks, :completed_by
    add_index :tasks, :asset_id
  end
end

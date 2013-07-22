class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name

      t.timestamps
    end
  end
end

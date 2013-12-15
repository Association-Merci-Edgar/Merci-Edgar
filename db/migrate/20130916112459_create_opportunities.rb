class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|

      t.timestamps
    end
  end
end

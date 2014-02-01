class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string  :code
      t.string  :event
      t.string  :promoter
      t.boolean :distributed, default: false
      t.integer :account_id
      
      t.timestamps
    end
    add_index :coupons, :account_id    
  end
end

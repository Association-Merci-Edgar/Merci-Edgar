class CreateShowBuyers < ActiveRecord::Migration
  def change
    create_table :show_buyers do |t|
      t.string  :licence
      t.string  :avatar

      t.timestamps
    end
  end
end

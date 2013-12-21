class AddRemarkToSchedulings < ActiveRecord::Migration
  def change
    add_column :schedulings, :remark, :text
  end
end

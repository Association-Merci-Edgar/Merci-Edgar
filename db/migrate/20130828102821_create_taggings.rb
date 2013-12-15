class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :tag
      t.integer :asset_id
      t.string :asset_type

      t.timestamps
    end
    add_index :taggings, :tag_id
    add_index :taggings, :asset_id
  end
end

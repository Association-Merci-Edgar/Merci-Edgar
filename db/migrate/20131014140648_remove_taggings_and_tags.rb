class RemoveTaggingsAndTags < ActiveRecord::Migration
  def up
    drop_table :taggings
    drop_table :tags
  end

  def down
    create_table "taggings", :force => true do |t|
      t.integer  "tag_id"
      t.integer  "asset_id"
      t.string   "asset_type"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "taggings", ["asset_id"], :name => "index_taggings_on_asset_id"
    add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

    create_table "tags", :force => true do |t|
      t.string   "name"
      t.string   "type"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.integer  "account_id"
    end

    add_index "tags", ["account_id"], :name => "index_tags_on_account_id"
  end
end

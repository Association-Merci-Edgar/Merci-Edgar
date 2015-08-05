class RemoveActiveAdminTables < ActiveRecord::Migration
  def up
    drop_table :admin_users
    drop_table :active_admin_comments
  end

  def down

    create_table :admin_users do |t|
      t.string   "email",                  :default => "", :null => false
      t.string   "encrypted_password",     :default => "", :null => false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          :default => 0,  :null => false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at",                             :null => false
      t.datetime "updated_at",                             :null => false
    end


    create_table :active_admin_comments do |t|
      t.string   "namespace"
      t.text     "body"
      t.string   "resource_id",   :null => false
      t.string   "resource_type", :null => false
      t.integer  "author_id"
      t.string   "author_type"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
    end

  end
end

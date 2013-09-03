# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130903162059) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "accounts_users", :force => true do |t|
    t.integer "account_id"
    t.integer "user_id"
  end

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "postal_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "kind"
    t.integer  "contact_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "addresses", ["contact_id"], :name => "index_addresses_on_contact_datum_id"

  create_table "capacities", :force => true do |t|
    t.integer  "nb"
    t.string   "kind"
    t.integer  "venue_info_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "capacities", ["venue_info_id"], :name => "index_capacities_on_venue_id"

  create_table "contacts", :force => true do |t|
    t.string  "type"
    t.string  "name"
    t.string  "first_name"
    t.string  "last_name"
    t.integer "account_id"
    t.string  "avatar"
  end

  add_index "contacts", ["account_id"], :name => "index_contacts_on_account_id"

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.string   "kind"
    t.integer  "contact_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "emails", ["contact_id"], :name => "index_emails_on_contact_datum_id"

  create_table "people_structures", :force => true do |t|
    t.integer "structure_id"
    t.integer "person_id"
    t.string  "title"
  end

  create_table "phones", :force => true do |t|
    t.string   "number"
    t.string   "kind"
    t.integer  "contact_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "phones", ["contact_id"], :name => "index_phones_on_contact_datum_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

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
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "priority"
    t.string   "category"
    t.boolean  "specific_time"
    t.datetime "due_at"
    t.datetime "completed_at"
    t.integer  "asset_id"
    t.string   "asset_type"
    t.integer  "assigned_to"
    t.integer  "completed_by"
    t.integer  "account_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "tasks", ["account_id"], :name => "index_tasks_on_account_id"
  add_index "tasks", ["asset_id"], :name => "index_tasks_on_asset_id"
  add_index "tasks", ["assigned_to"], :name => "index_tasks_on_assigned_to"
  add_index "tasks", ["completed_by"], :name => "index_tasks_on_completed_by"
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "venue_infos", :force => true do |t|
    t.float    "depth"
    t.float    "width"
    t.float    "height"
    t.string   "kind"
    t.integer  "venue_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "bar"
    t.string   "period"
    t.boolean  "accompaniment"
    t.boolean  "residency"
    t.text     "remark"
  end

  add_index "venue_infos", ["venue_id"], :name => "index_venue_infos_on_venue_id"

  create_table "websites", :force => true do |t|
    t.string   "url"
    t.string   "kind"
    t.integer  "contact_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "websites", ["contact_id"], :name => "index_websites_on_contact_datum_id"

end

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

ActiveRecord::Schema.define(:version => 20130803162135) do

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
    t.integer  "contact_datum_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "addresses", ["contact_datum_id"], :name => "index_addresses_on_contact_datum_id"

  create_table "capacities", :force => true do |t|
    t.integer  "nb"
    t.string   "kind"
    t.integer  "venue_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "capacities", ["venue_id"], :name => "index_capacities_on_venue_id"

  create_table "contact_data", :force => true do |t|
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "contact_data", ["contactable_id"], :name => "index_contact_data_on_contactable_id"

  create_table "contacts", :force => true do |t|
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "street"
    t.string   "postal_code"
    t.string   "state"
    t.string   "city"
    t.string   "country"
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.string   "kind"
    t.integer  "contact_datum_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "emails", ["contact_datum_id"], :name => "index_emails_on_contact_datum_id"

  create_table "phones", :force => true do |t|
    t.string   "number"
    t.string   "kind"
    t.integer  "contact_datum_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "phones", ["contact_datum_id"], :name => "index_phones_on_contact_datum_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "account_id"
  end

  add_index "venues", ["account_id"], :name => "index_venues_on_account_id"

  create_table "websites", :force => true do |t|
    t.string   "url"
    t.string   "kind"
    t.integer  "contact_datum_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "websites", ["contact_datum_id"], :name => "index_websites_on_contact_datum_id"

end

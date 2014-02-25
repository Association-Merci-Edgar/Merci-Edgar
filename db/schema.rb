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

ActiveRecord::Schema.define(:version => 20140224193710) do

  create_table "abilitations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "kind",       :default => "member", :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

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
    t.text     "more_info"
    t.integer  "account_id"
  end

  add_index "addresses", ["account_id"], :name => "index_addresses_on_account_id"
  add_index "addresses", ["contact_id"], :name => "index_addresses_on_contact_datum_id"

  create_table "admin_users", :force => true do |t|
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

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "announcements", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.datetime "published_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "campaigns", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "capacities", :force => true do |t|
    t.integer  "nb"
    t.string   "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "room_id"
    t.boolean  "modular"
  end

  add_index "capacities", ["room_id"], :name => "index_capacities_on_room_id"

  create_table "contacts", :force => true do |t|
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.string   "name"
    t.string   "network_tags"
    t.string   "custom_tags"
    t.text     "remark"
    t.integer  "account_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "style_tags"
    t.string   "contract_tags"
    t.string   "capacity_tags"
    t.string   "venue_kind"
    t.integer  "duplicate_id"
    t.integer  "imported_at"
    t.string   "source"
  end

  add_index "contacts", ["account_id"], :name => "index_contacts_on_account_id"
  add_index "contacts", ["contactable_id"], :name => "index_contacts_on_contactable_id"
  add_index "contacts", ["duplicate_id"], :name => "index_contacts_on_duplicate_id"

  create_table "coupons", :force => true do |t|
    t.string   "code"
    t.string   "event"
    t.string   "promoter"
    t.boolean  "distributed", :default => false
    t.integer  "account_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "coupons", ["account_id"], :name => "index_coupons_on_account_id"

  create_table "customs", :force => true do |t|
    t.string   "custom"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "customs", ["account_id"], :name => "index_customs_on_account_id"

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.string   "kind"
    t.integer  "contact_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "emails", ["contact_id"], :name => "index_emails_on_contact_datum_id"

  create_table "favorite_contacts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorite_contacts", ["contact_id"], :name => "index_favorite_contacts_on_contact_id"
  add_index "favorite_contacts", ["user_id"], :name => "index_favorite_contacts_on_user_id"

  create_table "festivals", :force => true do |t|
    t.integer  "nb_edition"
    t.integer  "last_year"
    t.string   "avatar"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "festivals", ["account_id"], :name => "index_festivals_on_account_id"

  create_table "networks", :force => true do |t|
    t.string   "network"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "networks", ["account_id"], :name => "index_networks_on_account_id"

  create_table "note_reports", :force => true do |t|
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "opportunities", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "people", ["account_id"], :name => "index_people_on_account_id"

  create_table "people_structures", :force => true do |t|
    t.integer "person_id"
    t.integer "structure_id"
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

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "account_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "avatar"
  end

  add_index "projects", ["account_id"], :name => "index_projects_on_account_id"

  create_table "prospectings", :force => true do |t|
    t.integer  "start_month"
    t.integer  "end_month"
    t.integer  "scheduling_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "prospectings", ["scheduling_id"], :name => "index_prospectings_on_scheduling_id"

  create_table "relatives", :force => true do |t|
    t.integer  "user_id"
    t.integer  "person_id"
    t.integer  "structure_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "relatives", ["person_id"], :name => "index_relatives_on_person_id"
  add_index "relatives", ["structure_id"], :name => "index_relatives_on_structure_id"
  add_index "relatives", ["user_id"], :name => "index_relatives_on_user_id"

  create_table "reportings", :force => true do |t|
    t.integer  "report_id"
    t.string   "report_type"
    t.integer  "asset_id"
    t.string   "asset_type"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reportings", ["asset_id"], :name => "index_reportings_on_asset_id"
  add_index "reportings", ["project_id"], :name => "index_reportings_on_project_id"
  add_index "reportings", ["report_id"], :name => "index_reportings_on_report_id"
  add_index "reportings", ["user_id"], :name => "index_reportings_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.float    "depth"
    t.float    "width"
    t.float    "height"
    t.boolean  "bar"
    t.integer  "venue_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rooms", ["venue_id"], :name => "index_rooms_on_venue_id"

  create_table "schedulings", :force => true do |t|
    t.string       "name"
    t.integer      "show_host_id"
    t.string       "show_host_type"
    t.integer      "show_buyer_id"
    t.integer      "scheduler_id"
    t.string       "period"
    t.string       "contract_tags"
    t.string       "style_tags"
    t.datetime     "created_at",         :null => false
    t.datetime     "updated_at",         :null => false
    t.text         "remark"
    t.boolean      "discovery"
    t.string_array "prospecting_months"
  end

  add_index "schedulings", ["scheduler_id"], :name => "index_schedulings_on_scheduler_id"
  add_index "schedulings", ["show_buyer_id"], :name => "index_schedulings_on_show_buyer_id"
  add_index "schedulings", ["show_host_id"], :name => "index_schedulings_on_show_host_id"

  create_table "show_buyers", :force => true do |t|
    t.string   "licence"
    t.string   "avatar"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "account_id"
  end

  add_index "show_buyers", ["account_id"], :name => "index_show_buyers_on_account_id"

  create_table "structures", :force => true do |t|
    t.integer  "structurable_id"
    t.string   "structurable_type"
    t.string   "avatar"
    t.integer  "account_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "structures", ["structurable_id"], :name => "index_structures_on_structurable_id"

  create_table "styles", :force => true do |t|
    t.string   "style"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "styles", ["account_id"], :name => "index_styles_on_account_id"

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
    t.integer  "project_id"
  end

  add_index "tasks", ["account_id"], :name => "index_tasks_on_account_id"
  add_index "tasks", ["asset_id"], :name => "index_tasks_on_asset_id"
  add_index "tasks", ["assigned_to"], :name => "index_tasks_on_assigned_to"
  add_index "tasks", ["completed_by"], :name => "index_tasks_on_completed_by"
  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"
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
    t.boolean  "welcome_hidden"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "venues", :force => true do |t|
    t.string       "kind"
    t.boolean      "residency"
    t.boolean      "accompaniment"
    t.string       "avatar"
    t.integer      "account_id"
    t.datetime     "created_at",    :null => false
    t.datetime     "updated_at",    :null => false
    t.string_array "season_months"
  end

  add_index "venues", ["account_id"], :name => "index_venues_on_account_id"

  create_table "websites", :force => true do |t|
    t.string   "url"
    t.string   "kind"
    t.integer  "contact_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "websites", ["contact_id"], :name => "index_websites_on_contact_datum_id"

end

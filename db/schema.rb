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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170511215738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "village"
    t.string   "road"
    t.integer  "word_no"
    t.string   "district"
    t.string   "upazila"
    t.string   "post_office"
    t.string   "address_type"
    t.string   "lang"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "basic_infos", force: :cascade do |t|
    t.string   "name"
    t.string   "fathers_name"
    t.string   "mothers_name"
    t.string   "maritial_status"
    t.string   "nid"
    t.string   "birth_id"
    t.string   "date_of_birth"
    t.string   "lang"
    t.integer  "infoable_id"
    t.string   "infoable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "state"
  end

  add_index "basic_infos", ["infoable_type", "infoable_id"], name: "index_basic_infos_on_infoable_type_and_infoable_id", using: :btree

  create_table "citizens", force: :cascade do |t|
    t.string   "name_in_eng"
    t.string   "name_in_bng"
    t.string   "fathers_name"
    t.string   "mothers_name"
    t.string   "village"
    t.string   "post"
    t.integer  "word_no"
    t.integer  "union_id"
    t.string   "spouse_name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "nid"
    t.string   "birthid"
    t.string   "status",       default: "active"
    t.string   "email"
    t.string   "mobile_no"
    t.datetime "requested_at"
    t.datetime "saved_at"
    t.string   "gender"
    t.string   "citizen_no"
  end

  add_index "citizens", ["union_id"], name: "index_citizens_on_union_id", using: :btree

  create_table "collection_moneys", force: :cascade do |t|
    t.decimal  "fee"
    t.decimal  "remain"
    t.decimal  "fine"
    t.decimal  "vat"
    t.integer  "collectable_id"
    t.string   "collectable_type"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "serial_no"
    t.integer  "union_id"
    t.string   "status",           default: "active"
  end

  add_index "collection_moneys", ["collectable_type", "collectable_id"], name: "index_collection_moneys_on_collectable_type_and_collectable_id", using: :btree
  add_index "collection_moneys", ["union_id"], name: "index_collection_moneys_on_union_id", using: :btree

  create_table "contact_addresses", force: :cascade do |t|
    t.string   "mobile_no"
    t.string   "email"
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "contact_addresses", ["contactable_type", "contactable_id"], name: "index_contact_addresses_on_contactable_type_and_contactable_id", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "name_in_eng"
    t.string   "name_in_bng"
    t.string   "desc"
    t.integer  "division_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "districts", ["division_id"], name: "index_districts_on_division_id", using: :btree

  create_table "divisions", force: :cascade do |t|
    t.string   "name_in_eng"
    t.string   "name_in_bng"
    t.string   "desc"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "others_collections", force: :cascade do |t|
    t.string   "senders_name"
    t.string   "senders_address"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "union_id"
    t.string   "status",                 default: "active"
    t.string   "time_line"
    t.string   "owners_name_in_english"
    t.string   "reason"
  end

  add_index "others_collections", ["union_id"], name: "index_others_collections_on_union_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
  end

  create_table "tax_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_or_rate_collections", force: :cascade do |t|
    t.string   "village_name"
    t.string   "owners_name"
    t.string   "apprisal_no"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "union_id"
    t.string   "status",                 default: "active"
    t.string   "owners_name_in_english"
    t.integer  "tax_category_id"
    t.string   "other_reason"
    t.string   "tax_year"
  end

  add_index "tax_or_rate_collections", ["tax_category_id"], name: "index_tax_or_rate_collections_on_tax_category_id", using: :btree
  add_index "tax_or_rate_collections", ["union_id"], name: "index_tax_or_rate_collections_on_union_id", using: :btree

  create_table "trade_licenses", force: :cascade do |t|
    t.integer  "fiscal_year"
    t.integer  "trade_organization_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.date     "issur_date"
  end

  add_index "trade_licenses", ["trade_organization_id"], name: "index_trade_licenses_on_trade_organization_id", using: :btree

  create_table "trade_organizations", force: :cascade do |t|
    t.string   "enterprize_name_in_eng"
    t.string   "enterprize_name_in_bng"
    t.string   "owners_name_eng"
    t.string   "owners_name_bng"
    t.string   "fathers_name"
    t.string   "mothers_name"
    t.string   "spouse_name"
    t.string   "village_name"
    t.string   "post_name"
    t.string   "upazilla_name"
    t.string   "zilla_name"
    t.string   "business_place"
    t.string   "business_category"
    t.integer  "union_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "license_no"
    t.integer  "word_no"
    t.string   "holding_no"
    t.string   "status",                 default: "active"
    t.string   "nid"
    t.string   "birthid"
  end

  add_index "trade_organizations", ["union_id"], name: "index_trade_organizations_on_union_id", using: :btree

  create_table "unions", force: :cascade do |t|
    t.string   "name_in_eng"
    t.string   "name_in_bng"
    t.integer  "upazila_id"
    t.integer  "union_no"
    t.string   "post"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "logo"
    t.string   "watermark_logo"
    t.string   "union_code"
    t.boolean  "show_signature", default: false
    t.string   "chairman_name"
  end

  add_index "unions", ["upazila_id"], name: "index_unions_on_upazila_id", using: :btree

  create_table "upazilas", force: :cascade do |t|
    t.string   "name_in_eng"
    t.string   "name_in_bng"
    t.integer  "district_id"
    t.string   "desc"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "upazilas", ["district_id"], name: "index_upazilas_on_district_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "union_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["union_id"], name: "index_users_on_union_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "citizens", "unions"
  add_foreign_key "collection_moneys", "unions"
  add_foreign_key "districts", "divisions"
  add_foreign_key "others_collections", "unions"
  add_foreign_key "tax_or_rate_collections", "tax_categories"
  add_foreign_key "tax_or_rate_collections", "unions"
  add_foreign_key "trade_licenses", "trade_organizations"
  add_foreign_key "trade_organizations", "unions"
  add_foreign_key "unions", "upazilas"
  add_foreign_key "upazilas", "districts"
  add_foreign_key "users", "unions"
end

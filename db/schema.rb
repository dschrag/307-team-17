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

ActiveRecord::Schema.define(version: 20151112021331) do

  create_table "houses", force: :cascade do |t|
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.decimal  "item_price",  precision: 8, scale: 2
    t.integer  "item_amount"
    t.string   "item_name"
    t.boolean  "visibility"
    t.integer  "frequency"
    t.integer  "user_id"
    t.integer  "house_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "items", ["house_id"], name: "index_items_on_house_id"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "notes", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "permissions_id"
  end

  add_index "notes", ["permissions_id"], name: "index_notes_on_permissions_id"
  add_index "notes", ["user_id", "created_at"], name: "index_notes_on_user_id_and_created_at"
  add_index "notes", ["user_id"], name: "index_notes_on_user_id"

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "level"
    t.integer  "permissable_id"
    t.string   "permissable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "permissions", ["permissable_type", "permissable_id"], name: "index_permissions_on_permissable_type_and_permissable_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "house_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "relationships", ["house_id"], name: "index_relationships_on_house_id"
  add_index "relationships", ["user_id"], name: "index_relationships_on_user_id"

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "buyer"
    t.string   "seller"
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "USD", null: false
    t.boolean  "recurring"
    t.text     "reason"
    t.date     "date_due"
    t.date     "date_paid"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end

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

ActiveRecord::Schema.define(version: 20151015032931) do

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
    t.integer  "item_price"
    t.integer  "item_amount"
    t.string   "item_name"
    t.boolean  "visibility"
    t.integer  "user_id"
    t.integer  "house_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["house_id"], name: "index_items_on_house_id"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "notes", force: :cascade do |t|
<<<<<<< HEAD
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notes", ["user_id", "created_at"], name: "index_notes_on_user_id_and_created_at"
=======
    t.string   "message"
    t.integer  "user_id"
    t.integer  "usersCanSee"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

>>>>>>> b98056380c75e525aa7b8216cff93df457da0be8
  add_index "notes", ["user_id"], name: "index_notes_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "house_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "relationships", ["house_id"], name: "index_relationships_on_house_id"
  add_index "relationships", ["user_id"], name: "index_relationships_on_user_id"

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

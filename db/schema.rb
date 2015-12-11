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

ActiveRecord::Schema.define(version: 20151206230225) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "comments", force: :cascade do |t|
    t.text     "reply"
    t.integer  "note_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["note_id"], name: "index_comments_on_note_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "finances", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "net_balance_cents",            default: 0,     null: false
    t.string   "net_balance_currency",         default: "USD", null: false
    t.integer  "net_income_cents",             default: 0,     null: false
    t.string   "net_income_currency",          default: "USD", null: false
    t.integer  "net_expenses_cents",           default: 0,     null: false
    t.string   "net_expenses_currency",        default: "USD", null: false
    t.integer  "expenses_last_month_cents",    default: 0,     null: false
    t.string   "expenses_last_month_currency", default: "USD", null: false
    t.integer  "income_last_month_cents",      default: 0,     null: false
    t.string   "income_last_month_currency",   default: "USD", null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "finances", ["user_id"], name: "index_finances_on_user_id"

  create_table "houses", force: :cascade do |t|
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "polls_id"
  end

  add_index "houses", ["polls_id"], name: "index_houses_on_polls_id"

  create_table "invitations", force: :cascade do |t|
    t.string   "token"
    t.integer  "user_id"
    t.integer  "house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "invitations", ["token"], name: "index_invitations_on_token"

  create_table "items", force: :cascade do |t|
    t.integer  "item_price_cents",    default: 0,     null: false
    t.string   "item_price_currency", default: "USD", null: false
    t.integer  "item_amount"
    t.string   "item_name"
    t.boolean  "visibility"
    t.boolean  "owned"
    t.integer  "frequency"
    t.integer  "prev_amount"
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
    t.integer  "lastEditedBy"
    t.string   "title"
    t.integer  "house_id"
  end

  add_index "notes", ["house_id"], name: "index_notes_on_house_id"
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

  create_table "polls", force: :cascade do |t|
    t.text     "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "house_id"
  end

  add_index "polls", ["house_id"], name: "index_polls_on_house_id"

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
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "number"
    t.date     "bornon"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "vote_options", force: :cascade do |t|
    t.string   "title"
    t.integer  "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vote_options", ["poll_id"], name: "index_vote_options_on_poll_id"

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vote_option_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id"
  add_index "votes", ["vote_option_id", "user_id"], name: "index_votes_on_vote_option_id_and_user_id", unique: true
  add_index "votes", ["vote_option_id"], name: "index_votes_on_vote_option_id"

end

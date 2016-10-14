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

ActiveRecord::Schema.define(version: 20161013044009) do

  create_table "authors", force: :cascade do |t|
    t.integer  "goodreads_author_id"
    t.string   "name"
    t.string   "image_url"
    t.string   "link"
    t.float    "rating"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "book_author_relationships", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_author_relationships", ["author_id"], name: "index_book_author_relationships_on_author_id"
  add_index "book_author_relationships", ["book_id"], name: "index_book_author_relationships_on_book_id"

  create_table "book_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.integer  "goodreads_book_id"
    t.string   "title"
    t.string   "description",       limit: 3000
    t.string   "publisher"
    t.string   "link"
    t.string   "image_url"
    t.float    "rating"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "subscription_types", force: :cascade do |t|
    t.integer  "days"
    t.integer  "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "from_date"
    t.datetime "to_date"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["book_id"], name: "index_subscriptions_on_book_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.integer  "goodreads_user_id", limit: 8
    t.string   "name"
    t.string   "img_url"
    t.string   "address"
    t.string   "join_date"
    t.string   "gender"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end

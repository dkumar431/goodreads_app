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

ActiveRecord::Schema.define(version: 20161008163304) do

  create_table "authors", force: :cascade do |t|
    t.integer  "goodreads_author_id", limit: 4
    t.string   "name",                limit: 255
    t.string   "image_url",           limit: 255
    t.string   "link",                limit: 255
    t.float    "rating",              limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "book_author_relationships", force: :cascade do |t|
    t.integer  "book_id",    limit: 4
    t.integer  "author_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "book_author_relationships", ["author_id"], name: "index_book_author_relationships_on_author_id", using: :btree
  add_index "book_author_relationships", ["book_id"], name: "index_book_author_relationships_on_book_id", using: :btree

  create_table "book_relationships", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "book_id",    limit: 4
    t.string   "type",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "book_relationships", ["book_id"], name: "fk_rails_539a0d765c", using: :btree
  add_index "book_relationships", ["user_id"], name: "fk_rails_598d0c60df", using: :btree

  create_table "books", force: :cascade do |t|
    t.integer  "goodreads_book_id", limit: 4
    t.string   "title",             limit: 255
    t.string   "description",       limit: 3000
    t.string   "publisher",         limit: 255
    t.string   "link",              limit: 255
    t.string   "image_url",         limit: 255
    t.float    "rating",            limit: 24
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "goodreads_user_id", limit: 8
    t.string   "name",              limit: 255
    t.string   "img_url",           limit: 255
    t.string   "address",           limit: 255
    t.string   "join_date",         limit: 255
    t.string   "gender",            limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_foreign_key "book_author_relationships", "authors"
  add_foreign_key "book_author_relationships", "books"
  add_foreign_key "book_relationships", "books"
  add_foreign_key "book_relationships", "users"
end

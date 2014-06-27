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

ActiveRecord::Schema.define(version: 20140625173852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.boolean  "starred",           default: false
    t.text     "guid"
    t.integer  "feed_id"
    t.boolean  "clicked",           default: false
    t.boolean  "seen",              default: false
    t.text     "title"
    t.text     "content"
    t.text     "author"
    t.text     "url"
    t.text     "source"
    t.datetime "article_published"
    t.datetime "article_updated"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["feed_id"], name: "index_articles_on_feed_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.integer  "category_id"
    t.text     "title"
    t.text     "feed_type"
    t.text     "htmlurl"
    t.text     "xmlurl"
    t.text     "comment"
    t.integer  "position"
    t.boolean  "works",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_count"
    t.text     "base_url"
  end

  add_index "feeds", ["category_id"], name: "index_feeds_on_category_id", using: :btree

  create_table "imports", force: true do |t|
    t.text     "raw_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

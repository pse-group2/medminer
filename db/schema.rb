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

ActiveRecord::Schema.define(version: 20140320142618) do

  create_table "article_term_links", force: true do |t|
    t.integer  "article_id"
    t.integer  "term_id"
    t.integer  "ranking"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.binary   "name",       limit: 255
    t.integer  "idwiki"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nouns", force: true do |t|
    t.integer  "term_id"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page", primary_key: "page_id", force: true do |t|
    t.integer "page_namespace",                                                                                                                  null: false
    t.binary  "page_title",         limit: 255,                                                                                                  null: false
    t.binary  "page_restrictions",  limit: 255,                                                                                                  null: false
    t.integer "page_counter",       limit: 8,   default: 0,                                                                                      null: false
    t.integer "page_is_redirect",   limit: 1,   default: 0,                                                                                      null: false
    t.integer "page_is_new",        limit: 1,   default: 0,                                                                                      null: false
    t.float   "page_random",                                                                                                                     null: false
    t.binary  "page_touched",       limit: 14,  default: "\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000", null: false
    t.binary  "page_links_updated", limit: 14
    t.integer "page_latest",                                                                                                                     null: false
    t.integer "page_len",                                                                                                                        null: false
    t.binary  "page_content_model", limit: 32
  end

  add_index "page", ["page_is_redirect", "page_namespace", "page_len"], name: "page_redirect_namespace_len", using: :btree
  add_index "page", ["page_len"], name: "page_len", using: :btree
  add_index "page", ["page_namespace", "page_title"], name: "name_title", unique: true, using: :btree
  add_index "page", ["page_random"], name: "page_random", using: :btree

  create_table "revision", primary_key: "rev_id", force: true do |t|
    t.integer "rev_page",                                                                                                                        null: false
    t.integer "rev_text_id",                                                                                                                     null: false
    t.binary  "rev_comment",        limit: 255,                                                                                                  null: false
    t.integer "rev_user",                       default: 0,                                                                                      null: false
    t.binary  "rev_user_text",      limit: 255,                                                                                                  null: false
    t.binary  "rev_timestamp",      limit: 14,  default: "\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000", null: false
    t.integer "rev_minor_edit",     limit: 1,   default: 0,                                                                                      null: false
    t.integer "rev_deleted",        limit: 1,   default: 0,                                                                                      null: false
    t.integer "rev_len"
    t.integer "rev_parent_id"
    t.binary  "rev_sha1",           limit: 32,                                                                                                   null: false
    t.binary  "rev_content_model",  limit: 32
    t.binary  "rev_content_format", limit: 64
  end

  add_index "revision", ["rev_page", "rev_id"], name: "rev_page_id", unique: true, using: :btree
  add_index "revision", ["rev_page", "rev_timestamp"], name: "page_timestamp", using: :btree
  add_index "revision", ["rev_page", "rev_user", "rev_timestamp"], name: "page_user_timestamp", using: :btree
  add_index "revision", ["rev_timestamp"], name: "rev_timestamp", using: :btree
  add_index "revision", ["rev_user", "rev_timestamp"], name: "user_timestamp", using: :btree
  add_index "revision", ["rev_user_text", "rev_timestamp"], name: "usertext_timestamp", using: :btree

  create_table "term_word_links", force: true do |t|
    t.integer  "term_id"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", force: true do |t|
    t.binary   "text",       limit: 255
    t.binary   "icd",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "text", primary_key: "old_id", force: true do |t|
    t.binary "old_text",  limit: 16777215, null: false
    t.binary "old_flags", limit: 255,      null: false
  end

  create_table "words", force: true do |t|
    t.binary   "text",       limit: 255
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

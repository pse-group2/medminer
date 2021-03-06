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

ActiveRecord::Schema.define(version: 20140327151554) do

  create_table "article_term_links", force: true do |t|
    t.integer  "article_id"
    t.integer  "term_id"
    t.integer  "ranking"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "name"
    t.integer  "idwiki"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page", primary_key: "page_id", force: true do |t|
    t.text    "page_title"
    t.integer "text_id"
  end

  create_table "term_nouns", force: true do |t|
    t.integer  "term_id"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_word_links", force: true do |t|
    t.integer  "term_id"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", force: true do |t|
    t.string   "text"
    t.string   "icd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "text", primary_key: "text_id", force: true do |t|
    t.integer "page_id",                  null: false
    t.binary  "content", limit: 16777215
  end

  create_table "words", force: true do |t|
    t.string   "text"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

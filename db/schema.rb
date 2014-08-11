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

ActiveRecord::Schema.define(version: 20140804035502) do

  create_table "citation_part_types", force: true do |t|
    t.string "code", limit: 10
  end

  add_index "citation_part_types", ["code"], name: "index_citation_part_types_on_code", unique: true

  create_table "citation_parts", force: true do |t|
    t.integer "source_id"
    t.integer "citation_part_type_id"
    t.string  "value"
  end

  add_index "citation_parts", ["source_id"], name: "index_citation_parts_on_source_id"

  create_table "repositories", force: true do |t|
    t.string   "name",       null: false
    t.text     "address"
    t.string   "website"
    t.string   "email"
    t.string   "phone"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repositories", ["name"], name: "index_repositories_on_name", unique: true

  create_table "sources", force: true do |t|
    t.string   "name",          null: false
    t.integer  "parent_id"
    t.string   "subject_place"
    t.string   "subject_date"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sources", ["parent_id"], name: "index_sources_on_parent_id"

end

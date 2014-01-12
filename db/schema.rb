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

ActiveRecord::Schema.define(version: 20140112162843) do

  create_table "page_views", force: true do |t|
    t.integer  "user_id"
    t.string   "page"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "method"
    t.string   "format"
  end

  create_table "private_messages", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",   default: false
  end

  create_table "users", force: true do |t|
    t.string   "id_token"
    t.string   "admin_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",       default: false
  end

  add_index "users", ["id_token"], name: "index_users_on_id_token", using: :btree

end

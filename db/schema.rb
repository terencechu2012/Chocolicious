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

ActiveRecord::Schema.define(version: 20140619064452) do

  create_table "claims", force: true do |t|
    t.string   "userid"
    t.string   "clubid"
    t.decimal  "amount",                  precision: 10, scale: 2
    t.integer  "status"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "supportdoc_file_name"
    t.string   "supportdoc_content_type"
    t.integer  "supportdoc_file_size"
    t.datetime "supportdoc_updated_at"
  end

  create_table "clubs", primary_key: "clubid", force: true do |t|
    t.string   "finsecid"
    t.string   "presidentid"
    t.string   "clubtype"
    t.string   "clubname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubusers", force: true do |t|
    t.string   "userid"
    t.string   "clubid"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clubusers", ["clubid"], name: "fk_1_idx", using: :btree
  add_index "clubusers", ["userid"], name: "fk_2_idx", using: :btree

  create_table "requests", force: true do |t|
    t.string   "userid"
    t.string   "clubid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", primary_key: "userid", force: true do |t|
    t.string   "passwordhash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nric"
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

end

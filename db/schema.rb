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

ActiveRecord::Schema.define(version: 20140928083238) do

  create_table "archive_budget_expenses", force: true do |t|
    t.integer  "budget_id"
    t.string   "item"
    t.decimal  "requestsac",      precision: 10, scale: 2, default: 0.0
    t.decimal  "requestreserves", precision: 10, scale: 2, default: 0.0
    t.decimal  "unitcost",        precision: 10, scale: 2, default: 0.0
    t.integer  "quantity",                                 default: 0
    t.string   "justification"
    t.string   "quotation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archive_budget_incomes", force: true do |t|
    t.integer  "budget_id"
    t.string   "item"
    t.decimal  "income",          precision: 10, scale: 2
    t.string   "incomebreakdown"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archive_budgets", force: true do |t|
    t.string   "clubid"
    t.string   "year"
    t.integer  "semester"
    t.string   "event"
    t.date     "startdate"
    t.date     "enddate"
    t.integer  "estnopar"
    t.string   "category"
    t.decimal  "requestsac",                             precision: 10, scale: 2, default: 0.0
    t.decimal  "requestreserves",                        precision: 10, scale: 2, default: 0.0
    t.decimal  "projectedincome",                        precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "explanation",         limit: 2147483647
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
  end

  create_table "archive_claims", force: true do |t|
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
    t.string   "remarks"
    t.string   "nric"
    t.string   "event"
  end

  create_table "archive_clubs", id: false, force: true do |t|
    t.string   "clubid",      default: "", null: false
    t.string   "finsecid"
    t.string   "presidentid"
    t.string   "clubtype"
    t.string   "clubname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "clubcode"
  end

  create_table "archive_clubusers", id: false, force: true do |t|
    t.integer  "id",         default: 0, null: false
    t.string   "userid"
    t.string   "clubid"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archive_deposits", force: true do |t|
    t.string   "userid"
    t.string   "clubid"
    t.decimal  "amount",     precision: 10, scale: 2
    t.integer  "status"
    t.string   "remarks"
    t.date     "date"
    t.string   "receipts"
    t.string   "donorname"
    t.string   "donoradd"
    t.string   "donoric"
    t.string   "purpose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archive_expenditure_accounts", force: true do |t|
    t.string   "clubid"
    t.decimal  "Category1Balance", precision: 10, scale: 2, default: 0.0
    t.decimal  "Category2Balance", precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archive_requests", force: true do |t|
    t.string   "userid"
    t.string   "clubid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archive_reserve_accounts", force: true do |t|
    t.string   "clubid"
    t.decimal  "balance",                          precision: 10, scale: 2
    t.decimal  "limit",                            precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "justification", limit: 2147483647
  end

  create_table "archive_users", primary_key: "userid", force: true do |t|
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
    t.string   "fullname"
    t.string   "contactno"
  end

  create_table "budget_controls", force: true do |t|
    t.boolean  "open"
    t.string   "year"
    t.integer  "semester"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_expenses", force: true do |t|
    t.integer  "budget_id"
    t.string   "item"
    t.decimal  "requestsac",      precision: 10, scale: 2, default: 0.0
    t.decimal  "requestreserves", precision: 10, scale: 2, default: 0.0
    t.decimal  "unitcost",        precision: 10, scale: 2, default: 0.0
    t.integer  "quantity",                                 default: 0
    t.string   "justification"
    t.string   "quotation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budget_expenses", ["budget_id"], name: "index_budget_expenses_on_budget_id", using: :btree

  create_table "budget_incomes", force: true do |t|
    t.integer  "budget_id"
    t.string   "item"
    t.decimal  "income",          precision: 10, scale: 2
    t.string   "incomebreakdown"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budget_incomes", ["budget_id"], name: "index_budget_incomes_on_budget_id", using: :btree

  create_table "budgets", force: true do |t|
    t.string   "clubid"
    t.string   "year"
    t.integer  "semester"
    t.string   "event"
    t.date     "startdate"
    t.date     "enddate"
    t.integer  "estnopar"
    t.string   "category"
    t.decimal  "requestsac",                             precision: 10, scale: 2, default: 0.0
    t.decimal  "requestreserves",                        precision: 10, scale: 2, default: 0.0
    t.decimal  "projectedincome",                        precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "explanation",         limit: 2147483647
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
  end

  create_table "claim_times", force: true do |t|
    t.integer  "claimid"
    t.integer  "status"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "remarks"
    t.string   "nric"
    t.string   "event"
    t.string   "expense"
  end

  create_table "clubs", primary_key: "clubid", force: true do |t|
    t.string   "finsecid"
    t.string   "presidentid"
    t.string   "clubtype"
    t.string   "clubname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "clubcode"
  end

  create_table "clubusers", force: true do |t|
    t.string   "userid"
    t.string   "clubid"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clubusers", ["clubid"], name: "fk_1_idx", using: :btree
  add_index "clubusers", ["userid", "clubid", "role"], name: "userid", unique: true, using: :btree
  add_index "clubusers", ["userid"], name: "fk_2_idx", using: :btree

  create_table "contributions", force: true do |t|
    t.decimal  "rate",       precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposits", force: true do |t|
    t.string   "userid"
    t.string   "clubid"
    t.decimal  "amount",     precision: 10, scale: 2
    t.integer  "status"
    t.string   "remarks"
    t.date     "date"
    t.string   "receipts"
    t.string   "donorname"
    t.string   "donoradd"
    t.string   "donoric"
    t.string   "purpose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ereceipts", force: true do |t|
    t.string   "issuerid"
    t.string   "issuername"
    t.string   "payeename"
    t.string   "payeemail"
    t.decimal  "amount",      precision: 10, scale: 0
    t.decimal  "gst",         precision: 10, scale: 0
    t.string   "paytype"
    t.string   "description"
    t.string   "clubid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenditure_accounts", force: true do |t|
    t.string   "clubid"
    t.decimal  "Category1Balance", precision: 10, scale: 2, default: 0.0
    t.decimal  "Category2Balance", precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expenditure_accounts", ["clubid"], name: "EA_fk", using: :btree

  create_table "funds_transfers", force: true do |t|
    t.string   "userid"
    t.string   "clubidfrom"
    t.string   "clubidto"
    t.decimal  "amount",     precision: 10, scale: 2
    t.string   "remarks"
    t.integer  "status"
    t.string   "purpose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.string   "userid"
    t.string   "clubid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requests", ["userid", "clubid"], name: "userid", unique: true, using: :btree

  create_table "reserve_accounts", force: true do |t|
    t.string   "clubid"
    t.decimal  "balance",                          precision: 10, scale: 2
    t.decimal  "limit",                            precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "justification", limit: 2147483647
  end

  add_index "reserve_accounts", ["clubid"], name: "RA_fk", using: :btree

  create_table "reserve_limits", force: true do |t|
    t.string   "clubid"
    t.decimal  "amount",                        precision: 10, scale: 2
    t.text     "remarks",    limit: 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reserve_withdrawals", force: true do |t|
    t.string   "userid"
    t.string   "clubid"
    t.decimal  "amount",     precision: 10, scale: 2
    t.string   "purpose"
    t.string   "remarks"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.string   "clubid"
    t.string   "clubcode"
    t.string   "year"
    t.integer  "semester"
    t.string   "typeoftransaction"
    t.decimal  "amount",            precision: 10, scale: 2
    t.integer  "depositid"
    t.integer  "claimid"
    t.string   "event"
    t.string   "purpose"
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
    t.string   "fullname"
    t.string   "contactno"
  end

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "address"
    t.integer  "category"
    t.decimal  "price",           precision: 5, scale: 4
    t.decimal  "quality",         precision: 5, scale: 4
    t.decimal  "punctuality",     precision: 5, scale: 4
    t.decimal  "customerservice", precision: 5, scale: 4
    t.decimal  "overall",         precision: 5, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reviewers"
  end

end

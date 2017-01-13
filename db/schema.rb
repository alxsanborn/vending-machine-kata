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

ActiveRecord::Schema.define(version: 20170113160046) do

  create_table "coin_returns", force: :cascade do |t|
    t.integer  "user_total_coin_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["user_total_coin_id"], name: "index_coin_returns_on_user_total_coin_id"
  end

  create_table "coins", force: :cascade do |t|
    t.decimal  "weight"
    t.decimal  "diameter"
    t.decimal  "thickness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dimes", force: :cascade do |t|
    t.integer  "user_total_coin_id"
    t.integer  "coin_return_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["coin_return_id"], name: "index_dimes_on_coin_return_id"
    t.index ["user_total_coin_id"], name: "index_dimes_on_user_total_coin_id"
  end

  create_table "nickels", force: :cascade do |t|
    t.integer  "user_total_coin_id"
    t.integer  "coin_return_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["coin_return_id"], name: "index_nickels_on_coin_return_id"
    t.index ["user_total_coin_id"], name: "index_nickels_on_user_total_coin_id"
  end

  create_table "pennies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.boolean  "selected",   default: false
    t.integer  "quantity",   default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "quarters", force: :cascade do |t|
    t.integer  "user_total_coin_id"
    t.integer  "coin_return_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["coin_return_id"], name: "index_quarters_on_coin_return_id"
    t.index ["user_total_coin_id"], name: "index_quarters_on_user_total_coin_id"
  end

  create_table "user_total_coins", force: :cascade do |t|
    t.decimal  "value"
    t.boolean  "return_coins", default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end

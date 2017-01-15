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

ActiveRecord::Schema.define(version: 20170114172343) do

  create_table "coins", force: :cascade do |t|
    t.decimal  "weight"
    t.decimal  "diameter"
    t.decimal  "thickness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dimes", force: :cascade do |t|
    t.integer  "inserted_coin_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["inserted_coin_id"], name: "index_dimes_on_inserted_coin_id"
  end

  create_table "inserted_coins", force: :cascade do |t|
    t.decimal  "value"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_inserted_coins_on_order_id"
  end

  create_table "nickels", force: :cascade do |t|
    t.integer  "inserted_coin_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["inserted_coin_id"], name: "index_nickels_on_inserted_coin_id"
  end

  create_table "orders", force: :cascade do |t|
    t.boolean  "return_coins", default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "pennies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "quantity",   default: 0
    t.boolean  "selected",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "quarters", force: :cascade do |t|
    t.integer  "inserted_coin_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["inserted_coin_id"], name: "index_quarters_on_inserted_coin_id"
  end

end

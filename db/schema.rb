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
    t.string   "coin_image_file_name"
    t.string   "coin_image_content_type"
    t.integer  "coin_image_file_size"
    t.datetime "coin_image_updated_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "inserted_coins", force: :cascade do |t|
    t.decimal  "value"
    t.integer  "order_id"
    t.integer  "quarters",   default: 0
    t.integer  "dimes",      default: 0
    t.integer  "nickels",    default: 0
    t.integer  "pennies",    default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["order_id"], name: "index_inserted_coins_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.boolean  "return_coins", default: false
    t.boolean  "purchased",    default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "quantity",                   default: 0
    t.boolean  "selected",                   default: false
    t.string   "product_image_file_name"
    t.string   "product_image_content_type"
    t.integer  "product_image_file_size"
    t.datetime "product_image_updated_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

end

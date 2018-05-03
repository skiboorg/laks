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

ActiveRecord::Schema.define(version: 20180503092427) do

  create_table "carts", force: :cascade do |t|
    t.integer "client_id"
    t.index ["client_id"], name: "index_carts_on_client_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "cat_name"
    t.string "cat_image"
  end

  create_table "clients", force: :cascade do |t|
    t.string "client_email"
    t.string "client_name", default: ""
    t.string "client_family", default: ""
    t.string "client_view_history", default: ""
    t.string "client_items_rate", default: ""
    t.boolean "client_vip", default: false
    t.boolean "client_mail_subscribe", default: true
    t.boolean "client_activated", default: false
    t.boolean "client_admin", default: false
    t.index ["client_email"], name: "index_clients_on_client_email"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "item_id"
    t.index ["item_id"], name: "index_comments_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "subcategory_id"
    t.string "item_name"
    t.string "item_name_caps"
    t.string "item_image", default: ""
    t.string "item_size", default: ""
    t.string "item_model", default: ""
    t.string "item_badge", default: ""
    t.string "item_page_title", default: ""
    t.string "item_page_description", default: ""
    t.integer "item_price"
    t.integer "item_rating", default: 0
    t.integer "item_discount", default: 0
    t.boolean "item_in_sale", default: false
    t.boolean "item_presents", default: true
    t.index ["item_name"], name: "index_items_on_item_name"
    t.index ["item_name_caps"], name: "index_items_on_item_name_caps"
    t.index ["subcategory_id"], name: "index_items_on_subcategory_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.integer "category_id"
    t.string "subcat_name"
    t.string "subcat_image"
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "client_id"
    t.index ["client_id"], name: "index_wishlists_on_client_id"
  end

end

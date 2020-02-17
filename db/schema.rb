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

ActiveRecord::Schema.define(version: 2020_02_16_123218) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "venue_id"
    t.index ["venue_id"], name: "index_addresses_on_venue_id"
  end

  create_table "amenities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "venue_id"
    t.index ["venue_id"], name: "index_amenities_on_venue_id"
  end

  create_table "booking_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "time_use_start"
    t.datetime "time_use_close"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "space_id"
    t.bigint "user_id"
    t.bigint "payment_id"
    t.index ["payment_id"], name: "index_booking_details_on_payment_id"
    t.index ["space_id"], name: "index_booking_details_on_space_id"
    t.index ["user_id"], name: "index_booking_details_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "method"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "per_month", precision: 10
    t.decimal "per_day", precision: 10
    t.decimal "per_hour", precision: 10
    t.bigint "space_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_prices_on_space_id"
  end

  create_table "space_prices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "per_month", precision: 10
    t.decimal "per_day", precision: 10
    t.decimal "per_hour", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spaces", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.text "description"
    t.time "hour_open"
    t.time "hour_close"
    t.string "time_use_start"
    t.string "time_use_close"
    t.boolean "status"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "venue_id"
    t.bigint "manager_id"
    t.bigint "type_id"
    t.bigint "space_prices_id"
    t.index ["manager_id"], name: "index_spaces_on_manager_id"
    t.index ["space_prices_id"], name: "index_spaces_on_space_prices_id"
    t.index ["type_id"], name: "index_spaces_on_type_id"
    t.index ["venue_id"], name: "index_spaces_on_venue_id"
  end

  create_table "types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_role_id"
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  create_table "venues", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_venues_on_user_id"
  end

  add_foreign_key "addresses", "venues"
  add_foreign_key "amenities", "venues"
  add_foreign_key "booking_details", "payments"
  add_foreign_key "booking_details", "spaces"
  add_foreign_key "booking_details", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "prices", "spaces"
  add_foreign_key "spaces", "space_prices", column: "space_prices_id"
  add_foreign_key "spaces", "types"
  add_foreign_key "spaces", "users", column: "manager_id"
  add_foreign_key "spaces", "venues"
  add_foreign_key "users", "user_roles"
  add_foreign_key "venues", "users"
end

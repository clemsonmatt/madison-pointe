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

ActiveRecord::Schema.define(version: 20190202183104) do

  create_table "dues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "year"
    t.float "amount", limit: 24
    t.datetime "notified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dues_houses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "paid", default: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "due_id"
    t.bigint "house_id"
    t.text "stripe_details"
    t.index ["due_id"], name: "index_dues_houses_on_due_id"
    t.index ["house_id"], name: "index_dues_houses_on_house_id"
  end

  create_table "houses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "number"
    t.string "street"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "email_verified_at"
    t.datetime "verified_at"
    t.boolean "active", default: false, null: false
    t.string "verification_token"
    t.string "officer_position"
    t.bigint "house_id"
    t.index ["email"], name: "index_people_on_email"
    t.index ["house_id"], name: "index_people_on_house_id"
  end

  add_foreign_key "dues_houses", "dues"
  add_foreign_key "dues_houses", "houses"
  add_foreign_key "people", "houses"
end

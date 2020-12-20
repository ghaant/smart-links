# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_15_201957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "languages", force: :cascade do |t|
    t.string "code", limit: 2, null: false
    t.string "name", limit: 50, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "ux_languages_code", unique: true
    t.index ["name"], name: "ux_languages_name", unique: true
  end

  create_table "redirections", force: :cascade do |t|
    t.integer "smartlink_id", null: false
    t.integer "language_id", null: false
    t.string "url", limit: 255, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["smartlink_id", "language_id"], name: "ux_redirections", unique: true
  end

  create_table "smartlinks", force: :cascade do |t|
    t.string "slug", limit: 50, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "ux_smartlinks_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", limit: 50, null: false
    t.string "password_digest", limit: 255, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "ux_users_email", unique: true
  end

  add_foreign_key "redirections", "languages", name: "fk_redirections_language_id"
  add_foreign_key "redirections", "smartlinks", name: "fk_redirections_smartlink_id"
end

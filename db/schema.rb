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

ActiveRecord::Schema.define(version: 2018_06_06_000011) do

  create_table "characters", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.integer "age"
    t.string "sex"
    t.text "background"
    t.integer "experience_points"
    t.decimal "money"
    t.integer "user_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "mail"
    t.string "last_name"
    t.string "first_name"
    t.string "username"
    t.string "encrypted_password"
    t.string "salt"
    t.datetime "inscription_date"
    t.integer "level"
  end

end

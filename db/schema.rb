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

ActiveRecord::Schema.define(version: 2020_06_04_183955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bikes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bikes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "suspension_part_assignments", force: :cascade do |t|
    t.bigint "bike_id", null: false
    t.bigint "suspension_part_id", null: false
    t.datetime "assigned_at", null: false
    t.datetime "removed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bike_id"], name: "index_suspension_part_assignments_on_bike_id"
    t.index ["suspension_part_id"], name: "index_suspension_part_assignments_on_suspension_part_id"
  end

  create_table "suspension_parts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "component_type", null: false
    t.boolean "high_speed_compression", default: false, null: false
    t.boolean "low_speed_compression", default: true, null: false
    t.boolean "high_speed_rebound", default: false, null: false
    t.boolean "low_speed_rebound", default: true, null: false
    t.boolean "volume", default: true, null: false
    t.boolean "pressure", default: true, null: false
    t.boolean "spring_rate", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_suspension_parts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bikes", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "suspension_part_assignments", "bikes"
  add_foreign_key "suspension_part_assignments", "suspension_parts"
  add_foreign_key "suspension_parts", "users"
end

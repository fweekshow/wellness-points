# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_07_07_170218) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ally_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ally_user_id"
    t.index ["user_id"], name: "index_allies_on_user_id"
  end

  create_table "point_transactions", force: :cascade do |t|
    t.bigint "giver_id", null: false
    t.bigint "receiver_id", null: false
    t.string "task"
    t.integer "points"
    t.boolean "claimed"
    t.datetime "claimed_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["giver_id"], name: "index_point_transactions_on_giver_id"
    t.index ["receiver_id"], name: "index_point_transactions_on_receiver_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ally_id", null: false
    t.string "title"
    t.text "description"
    t.integer "points"
    t.string "status", default: "pending"
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ally_id"], name: "index_tasks_on_ally_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.string "wallet_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points", default: 0, null: false
    t.string "alias"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "allies", "users"
  add_foreign_key "point_transactions", "users", column: "giver_id"
  add_foreign_key "point_transactions", "users", column: "receiver_id"
  add_foreign_key "tasks", "allies"
  add_foreign_key "tasks", "users"
end

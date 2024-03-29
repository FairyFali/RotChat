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

ActiveRecord::Schema.define(version: 2018_12_24_011914) do

  create_table "_machine_messages_old_20181130", force: :cascade do |t|
    t.integer "user_id"
    t.integer "machine_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type"
  end

  create_table "chats", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chat_id", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.string "idcard"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machine_messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "machine_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type2"
  end

  create_table "machines", force: :cascade do |t|
    t.string "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "url"
    t.integer "score"
    t.integer "duration"
    t.integer "code"
    t.integer "req_num"
    t.string "memo"
    t.integer "bolg_id"
  end

  create_table "machines_users", force: :cascade do |t|
    t.integer "machine_id", null: false
    t.integer "user_id", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "text"
    t.integer "user_id"
    t.integer "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "nickname"
    t.string "img_url"
    t.string "memo"
    t.datetime "birthdate"
    t.string "profession"
    t.string "address"
    t.string "company"
    t.string "university"
    t.string "phone"
    t.string "sex"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

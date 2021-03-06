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

ActiveRecord::Schema.define(version: 20180411022159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "rank"
    t.string "suit"
    t.integer "value"
    t.integer "straight_id"
  end

  create_table "friend_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sender_id"
    t.integer "requested_id"
    t.boolean "accepted", default: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_user_id"
    t.index ["friend_user_id", "user_id"], name: "index_friendships_on_friend_user_id_and_user_id", unique: true
    t.index ["user_id", "friend_user_id"], name: "index_friendships_on_user_id_and_friend_user_id", unique: true
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "poker_room_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.boolean "computer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "poker_rooms", force: :cascade do |t|
    t.integer "player_count"
    t.integer "player1"
    t.integer "player2"
    t.integer "player3"
    t.integer "player4"
    t.integer "player5"
    t.integer "player6"
    t.integer "player7"
    t.integer "player8"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_round"
  end

  create_table "poker_rounds", force: :cascade do |t|
    t.integer "player1"
    t.integer "player2"
    t.integer "player3"
    t.integer "player4"
    t.integer "player5"
    t.integer "player6"
    t.integer "player7"
    t.integer "player8"
    t.integer "pot"
    t.integer "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "poker_room_id"
  end

  create_table "private_messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "balance"
    t.boolean "email_confirmed"
    t.string "confirm_token"
    t.string "channel_key"
    t.boolean "online"
    t.string "remember_digest"
    t.integer "current_room"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end

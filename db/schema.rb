# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140105221748) do

  create_table "groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hackers", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "github"
    t.string   "tshirt_size"
    t.text     "why"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "school_id"
    t.integer  "team_id"
    t.integer  "g_contributions"
    t.integer  "g_followers"
    t.integer  "g_stars"
    t.float    "rating"
    t.integer  "status_id"
    t.string   "contact_date"
  end

  add_index "hackers", ["school_id"], name: "index_hackers_on_school_id"
  add_index "hackers", ["team_id"], name: "index_hackers_on_team_id"

  create_table "ratings", force: true do |t|
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hacker_id"
  end

  add_index "ratings", ["hacker_id"], name: "index_ratings_on_hacker_id"

  create_table "schools", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "teams", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating_avg"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

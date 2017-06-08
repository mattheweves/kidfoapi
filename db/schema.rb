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

ActiveRecord::Schema.define(version: 20170607235625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "families", force: :cascade do |t|
    t.string   "name"
    t.string   "avatar"
    t.string   "emerg_contact_1"
    t.string   "emerg_contact_1_phone"
    t.string   "emerg_contact_2"
    t.string   "emerg_contact_2_phone"
    t.string   "insuranceprovider"
    t.string   "health_ins_enrollee_id"
    t.string   "health_ins_group_num"
    t.string   "physicianname"
    t.string   "physicianphone"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "kid_id"
    t.string   "category"
    t.string   "name"
    t.string   "description"
    t.string   "image_link"
    t.string   "book_isbn"
    t.string   "movie_cast"
    t.string   "movie_trailer_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.integer  "status"
    t.string   "code"
    t.integer  "family_id"
    t.integer  "user_id"
    t.integer  "invite_kind"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["code"], name: "index_invites_on_code", using: :btree
    t.index ["family_id"], name: "index_invites_on_family_id", using: :btree
    t.index ["status"], name: "index_invites_on_status", using: :btree
    t.index ["user_id"], name: "index_invites_on_user_id", using: :btree
  end

  create_table "kids", force: :cascade do |t|
    t.string   "name"
    t.string   "birthdate"
    t.string   "gender"
    t.string   "insuranceprovider"
    t.string   "bedtime"
    t.text     "sleeproutine"
    t.text     "eatdetails"
    t.string   "allergies"
    t.string   "nonos"
    t.integer  "family_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "picture"
    t.index ["family_id"], name: "index_kids_on_family_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "avatar"
    t.string   "motto"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "family_id"
    t.string   "authentication_token",   limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end

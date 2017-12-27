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

ActiveRecord::Schema.define(version: 20171223151400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "category"
    t.string   "school"
    t.date     "start"
    t.date     "end"
    t.string   "status"
    t.string   "city"
    t.string   "country"
    t.string   "description"
    t.string   "website"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "logo"
  end

  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.string   "company"
    t.string   "position"
    t.date     "start"
    t.date     "end"
    t.string   "category"
    t.text     "description"
    t.string   "termination"
    t.string   "website"
    t.string   "phone1"
    t.string   "phone2"
    t.text     "comment"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "address"
    t.text     "achievement"
    t.text     "responsabilities"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
  end

  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "technology"
    t.text     "description"
    t.string   "link"
    t.string   "logo"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "skillexperiences", force: :cascade do |t|
    t.integer  "skill_id"
    t.integer  "experience_id"
    t.text     "comment"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "skillexperiences", ["experience_id"], name: "index_skillexperiences_on_experience_id", using: :btree
  add_index "skillexperiences", ["skill_id"], name: "index_skillexperiences_on_skill_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "years"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "category"
  end

  add_index "skills", ["user_id"], name: "index_skills_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "role"
  end

  add_foreign_key "courses", "users"
  add_foreign_key "experiences", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "skillexperiences", "experiences"
  add_foreign_key "skillexperiences", "skills"
  add_foreign_key "skills", "users"
end

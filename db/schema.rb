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

ActiveRecord::Schema.define(version: 20150121183634) do

  create_table "attendance_statuses", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "label",      limit: 255
  end

  create_table "observation_types", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "label",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "observations", force: :cascade do |t|
    t.integer  "participant_id",      limit: 4
    t.integer  "observation_type_id", limit: 4
    t.string   "course",              limit: 255
    t.date     "observed_on"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "observations", ["observation_type_id"], name: "index_observations_on_observation_type_id", using: :btree
  add_index "observations", ["participant_id"], name: "index_observations_on_participant_id", using: :btree

  create_table "participant_activities", force: :cascade do |t|
    t.integer  "participant_id", limit: 4
    t.string   "title",          limit: 255
    t.text     "description",    limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "participant_activities", ["participant_id"], name: "index_participant_activities_on_participant_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.string   "andrewid",          limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "is_admin",          limit: 1,     default: false
    t.string   "name_cache",        limit: 255
    t.text     "note",              limit: 65535
    t.boolean  "in_future_faculty", limit: 1
  end

  create_table "project_statuses", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "label",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "project_types", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "label",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "participant_id",    limit: 4
    t.integer  "project_type_id",   limit: 4
    t.integer  "project_status_id", limit: 4
    t.text     "description",       limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "projects", ["participant_id"], name: "index_projects_on_participant_id", using: :btree
  add_index "projects", ["project_status_id"], name: "index_projects_on_project_status_id", using: :btree
  add_index "projects", ["project_type_id"], name: "index_projects_on_project_type_id", using: :btree

  create_table "registration_statuses", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "participant_id",         limit: 4
    t.integer  "seminar_id",             limit: 4
    t.integer  "registration_status_id", limit: 4
    t.integer  "attendance_status_id",   limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "registrations", ["attendance_status_id"], name: "index_registrations_on_attendance_status_id", using: :btree
  add_index "registrations", ["participant_id"], name: "index_registrations_on_participant_id", using: :btree
  add_index "registrations", ["registration_status_id"], name: "index_registrations_on_registration_status_id", using: :btree
  add_index "registrations", ["seminar_id"], name: "index_registrations_on_seminar_id", using: :btree

  create_table "requirement_categories", force: :cascade do |t|
    t.string   "label",      limit: 255
    t.string   "key",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "requirements_versions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "seminar_statuses", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "seminar_tags", force: :cascade do |t|
    t.integer  "seminar_id", limit: 4
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "seminar_tags", ["seminar_id"], name: "index_seminar_tags_on_seminar_id", using: :btree

  create_table "seminars", force: :cascade do |t|
    t.string   "title",                        limit: 255
    t.text     "description",                  limit: 65535
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "seminar_status_id",            limit: 4
    t.integer  "maximum_capacity",             limit: 4
    t.integer  "participants_confirmed_cache", limit: 4
    t.string   "location",                     limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "seminars", ["seminar_status_id"], name: "index_seminars_on_seminar_status_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "label",      limit: 255
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end

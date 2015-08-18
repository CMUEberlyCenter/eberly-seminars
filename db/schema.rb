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

ActiveRecord::Schema.define(version: 20150818174522) do

  create_table "attendance_statuses", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label",      limit: 255
  end

  create_table "future_faculty_requirement_categories", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "label",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "future_faculty_requirements", force: :cascade do |t|
    t.string   "key",                                    limit: 255
    t.string   "label",                                  limit: 255
    t.integer  "future_faculty_requirements_version_id", limit: 4
    t.integer  "future_faculty_requirement_category_id", limit: 4
    t.string   "activity_class",                         limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "future_faculty_requirements", ["future_faculty_requirement_category_id"], name: "index_ff_requirements_on_ff_requirement_category_id", using: :btree
  add_index "future_faculty_requirements", ["future_faculty_requirements_version_id"], name: "index_ff_requirements_on_ff_requirements_version_id", using: :btree

  create_table "future_faculty_requirements_versions", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "label",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "participant_activities", force: :cascade do |t|
    t.integer  "participant_id",                limit: 4
    t.string   "type",                          limit: 255
    t.integer  "future_faculty_requirement_id", limit: 4
    t.integer  "status_id",                     limit: 4
    t.string   "course",                        limit: 255
    t.string   "title",                         limit: 255
    t.string   "description",                   limit: 255
    t.integer  "observer_id",                   limit: 4
    t.integer  "lead_consultant_id",            limit: 4
    t.date     "completed_on"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "internal_notes",                limit: 255
    t.date     "memo_completed_on"
  end

  add_index "participant_activities", ["future_faculty_requirement_id"], name: "index_participant_activities_on_ff_requirement_id", using: :btree
  add_index "participant_activities", ["lead_consultant_id"], name: "index_participant_activities_on_lead_consultant_id", using: :btree
  add_index "participant_activities", ["observer_id"], name: "index_participant_activities_on_observer_id", using: :btree
  add_index "participant_activities", ["participant_id"], name: "index_participant_activities_on_participant_id", using: :btree
  add_index "participant_activities", ["status_id"], name: "index_participant_activities_on_status_id", using: :btree

  create_table "participant_activity_status_types", force: :cascade do |t|
    t.integer  "future_faculty_requirement_id", limit: 4
    t.string   "key",                           limit: 255
    t.string   "label",                         limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "participant_activity_status_types", ["future_faculty_requirement_id"], name: "fk_rails_bbf561d3fb", using: :btree

  create_table "participants", force: :cascade do |t|
    t.string   "andrewid",                          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",                          limit: 1,     default: false
    t.boolean  "consultant",                        limit: 1,     default: false
    t.string   "name_cache",                        limit: 255
    t.text     "note",                              limit: 65535
    t.integer  "future_faculty_enrollment_id",      limit: 4
    t.integer  "future_faculty_progress_status_id", limit: 4
  end

  add_index "participants", ["future_faculty_enrollment_id"], name: "index_participants_on_future_faculty_enrollment_id", using: :btree
  add_index "participants", ["future_faculty_progress_status_id"], name: "index_participants_on_future_faculty_progress_status_id", using: :btree

  create_table "program_progress_status_types", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "label",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "registration_statuses", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "participant_id",         limit: 4
    t.integer  "seminar_id",             limit: 4
    t.integer  "registration_status_id", limit: 4
    t.integer  "attendance_status_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["attendance_status_id"], name: "index_registrations_on_attendance_status_id", using: :btree
  add_index "registrations", ["participant_id"], name: "index_registrations_on_participant_id", using: :btree
  add_index "registrations", ["registration_status_id"], name: "index_registrations_on_registration_status_id", using: :btree
  add_index "registrations", ["seminar_id"], name: "index_registrations_on_seminar_id", using: :btree

  create_table "seminar_statuses", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seminar_tags", force: :cascade do |t|
    t.integer  "seminar_id", limit: 4
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seminars", ["seminar_status_id"], name: "index_seminars_on_seminar_status_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "label",      limit: 255
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "future_faculty_requirements", "future_faculty_requirement_categories"
  add_foreign_key "future_faculty_requirements", "future_faculty_requirements_versions"
  add_foreign_key "participant_activities", "future_faculty_requirements"
  add_foreign_key "participant_activities", "participant_activity_status_types", column: "status_id"
  add_foreign_key "participant_activities", "participants"
  add_foreign_key "participant_activities", "participants"
  add_foreign_key "participant_activities", "participants", column: "lead_consultant_id"
  add_foreign_key "participant_activity_status_types", "future_faculty_requirements"
  add_foreign_key "participants", "future_faculty_requirements_versions", column: "future_faculty_enrollment_id"
  add_foreign_key "participants", "program_progress_status_types", column: "future_faculty_progress_status_id"
end

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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120404060408) do

  create_table "attendance_statuses", :force => true do |t|
    t.string   "attendance_status"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "participants", :force => true do |t|
    t.string   "andrewid"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "is_admin",   :default => false
  end

  create_table "registration_statuses", :force => true do |t|
    t.string   "registration_status"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "registrations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "seminar_id"
    t.integer  "registration_status_id"
    t.integer  "attendance_status_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "registrations", ["attendance_status_id"], :name => "index_registrations_on_attendance_status_id"
  add_index "registrations", ["registration_status_id"], :name => "index_registrations_on_registration_status_id"
  add_index "registrations", ["seminar_id"], :name => "index_registrations_on_seminar_id"
  add_index "registrations", ["user_id"], :name => "index_registrations_on_user_id"

  create_table "seminar_statuses", :force => true do |t|
    t.string   "seminar_status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "seminars", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "seminar_status_id"
    t.integer  "maximum_capacity"
    t.integer  "participants_confirmed_cache"
    t.string   "location"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "seminars", ["seminar_status_id"], :name => "index_seminars_on_seminar_status_id"

end

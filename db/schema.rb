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

ActiveRecord::Schema.define(version: 20150520172122) do

  create_table "body_parts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "user_id"
  end

  create_table "equipment_pieces", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "exercise_body_parts", force: true do |t|
    t.integer "exercise_id"
    t.integer "body_part_id"
  end

  create_table "exercise_categories", force: true do |t|
    t.integer "exercise_id"
    t.integer "category_id"
  end

  create_table "exercise_equipment_pieces", force: true do |t|
    t.integer "exercise_id"
    t.integer "equipment_piece_id"
  end

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "difficulty"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "votes", force: true do |t|
    t.boolean  "vote"
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workout_categories", force: true do |t|
    t.integer "workout_id"
    t.integer "category_id"
  end

  create_table "workout_exercises", force: true do |t|
    t.integer "workout_id"
    t.integer "exercise_id"
  end

  create_table "workouts", force: true do |t|
    t.string   "name"
    t.integer  "interval_min", limit: 255
    t.integer  "rest_min",     limit: 255
    t.text     "comment"
    t.integer  "reps"
    t.integer  "sets"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rest_sec"
    t.integer  "interval_sec"
    t.string   "slug"
  end

end

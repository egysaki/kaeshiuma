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

ActiveRecord::Schema.define(version: 20180815002841) do

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horse_race_results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "horse_id", null: false
    t.integer "race_info_id", null: false
    t.string "accomplishment_time"
    t.float "time_for_3f", limit: 24
    t.integer "order_of_placing"
    t.string "passing_info"
    t.integer "weight"
    t.float "basis_weight", limit: 24
    t.integer "popularity"
    t.integer "post_position"
    t.integer "horse_number"
    t.float "margin", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "odds", limit: 24
    t.string "pace"
    t.string "weight_difference"
    t.integer "jokey_id"
  end

  create_table "horses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "sex"
    t.integer "age"
    t.string "active_status"
    t.string "hair_color_type"
    t.date "birth_day"
    t.integer "trainer_id"
    t.integer "owner_id"
    t.integer "producer_id"
    t.integer "blood_line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.integer "father_id"
    t.integer "mother_id"
    t.integer "g_father_id"
  end

  create_table "jokeys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "race_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "race_id", null: false
    t.string "course_status"
    t.date "event_date"
    t.integer "times"
    t.integer "race_round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "weather"
  end

  create_table "races", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.integer "distance", null: false
    t.integer "course_id", null: false
    t.string "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "course_type"
  end

end

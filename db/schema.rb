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

ActiveRecord::Schema.define(version: 20180803054410) do

  create_table "horses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "sex", null: false
    t.integer "age", null: false
    t.string "active_status", null: false
    t.string "hair_color_type", null: false
    t.date "birth_day", null: false
    t.integer "trainer_id"
    t.integer "owner_id"
    t.integer "producer_id"
    t.integer "blood_line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link", null: false
    t.integer "father_id"
    t.integer "mother_id"
    t.integer "g_father_id"
  end

end

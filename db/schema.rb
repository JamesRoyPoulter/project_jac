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

ActiveRecord::Schema.define(:version => 20130901201215) do

  create_table "assets", :force => true do |t|
    t.string   "media"
    t.string   "file_type"
    t.integer  "checkin_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "color"
  end

  create_table "categories_checkins", :force => true do |t|
    t.integer  "category_id"
    t.integer  "checkin_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categories_checkins", ["category_id"], :name => "index_categories_checkins_on_category_id"
  add_index "categories_checkins", ["checkin_id"], :name => "index_categories_checkins_on_checkin_id"

  create_table "checkins", :force => true do |t|
    t.float    "latitude",                    :null => false
    t.float    "longitude",                   :null => false
    t.text     "title",       :default => ""
    t.integer  "user_id",                     :null => false
    t.string   "address"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.text     "description"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "picture"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people_checkins", :force => true do |t|
    t.integer  "person_id"
    t.integer  "checkin_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end

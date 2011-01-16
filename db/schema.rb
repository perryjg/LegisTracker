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

ActiveRecord::Schema.define(:version => 20110115190400) do

  create_table "bills", :force => true do |t|
    t.string  "btype"
    t.integer "num"
    t.string  "suffix"
    t.integer "carryover"
    t.integer "year_id"
    t.date    "status_date"
    t.string  "number"
    t.string  "short_title"
    t.string  "composite_caption"
    t.text    "title"
    t.integer "h_committee"
    t.integer "s_committee"
    t.date    "eff_date"
    t.string  "b_status"
    t.string  "status_code_id"
    t.text    "footnote"
    t.integer "code_title"
    t.integer "code_chapter"
  end

  create_table "house_feeds", :force => true do |t|
    t.string   "title"
    t.string   "summary"
    t.string   "author"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "senate_feeds", :force => true do |t|
    t.string   "title"
    t.string   "summary"
    t.string   "author"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "status_codes", :force => true do |t|
    t.string  "description"
    t.string  "house",       :limit => 1
    t.integer "seq"
  end

  create_table "statuses", :force => true do |t|
    t.integer  "bill_id"
    t.datetime "status_date"
    t.string   "status_code_id", :limit => 10
    t.string   "am_sub_desc"
  end

  create_table "votes", :force => true do |t|
    t.string   "house",       :limit => 1
    t.datetime "date"
    t.string   "bill_type",   :limit => 2
    t.integer  "num"
    t.string   "description"
    t.integer  "yea"
    t.integer  "nay"
    t.integer  "not_voting"
    t.integer  "excused"
    t.integer  "bill_id"
  end

end

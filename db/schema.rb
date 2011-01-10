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

ActiveRecord::Schema.define(:version => 20110110210951) do

  create_table "bills", :force => true do |t|
    t.string  "btype"
    t.integer "num"
    t.string  "suffix"
    t.integer "carryover"
    t.integer "yearID"
    t.date    "statusDate"
    t.string  "number"
    t.string  "short_title"
    t.string  "compositeCaption"
    t.text    "title"
    t.integer "hCommittee"
    t.integer "sCommittee"
    t.date    "EffDate"
    t.string  "bStatus"
    t.string  "statusCode"
    t.text    "Footnote"
    t.integer "codeTitle"
    t.integer "codeChapter"
  end

  create_table "statuses", :force => true do |t|
    t.integer  "bill_id"
    t.datetime "statusDate"
    t.string   "statusCode"
    t.string   "AmSubDesc"
  end

  create_table "votes", :force => true do |t|
    t.string   "house",       :limit => 1
    t.datetime "date"
    t.string   "type",        :limit => 2
    t.integer  "num"
    t.string   "description"
    t.integer  "yea"
    t.integer  "nay"
    t.integer  "not_voting"
    t.integer  "excused"
    t.integer  "bill_id"
  end

end

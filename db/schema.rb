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

ActiveRecord::Schema.define(:version => 0) do

  create_table "bills", :id => false, :force => true do |t|
    t.integer "id",                                                     :null => false
    t.string  "Btype",            :limit => 2,          :default => "", :null => false
    t.integer "Num",                                                    :null => false
    t.string  "Suffix",           :limit => 25
    t.integer "Carryover",                                              :null => false
    t.integer "YearID",                                                 :null => false
    t.date    "StatusDate",                                             :null => false
    t.string  "Number",           :limit => 8,                          :null => false
    t.string  "Short_Title",                                            :null => false
    t.string  "CompositeCaption",                                       :null => false
    t.text    "Title",            :limit => 2147483647,                 :null => false
    t.integer "HCommittee"
    t.integer "SCommittee"
    t.date    "EffDate"
    t.string  "BStatus"
    t.string  "statusCode",       :limit => 10
    t.text    "Footnote",         :limit => 16777215
    t.integer "codeTitle"
    t.integer "codeChapter"
  end

  create_table "committee_member_assignments_10", :force => true do |t|
    t.integer "committee_id"
    t.integer "member_id"
    t.string  "name"
    t.integer "district"
    t.string  "house",        :limit => 1
    t.string  "office"
  end

  create_table "committees", :id => false, :force => true do |t|
    t.integer "id",                       :null => false
    t.string  "name"
    t.string  "short_name", :limit => 10
    t.string  "house",      :limit => 1,  :null => false
  end

  create_table "members", :force => true do |t|
    t.string  "name",     :limit => 35, :null => false
    t.integer "district",               :null => false
    t.string  "lname",    :limit => 35
  end

  create_table "sponsor", :id => false, :force => true do |t|
    t.integer "bill_id", :null => false
    t.integer "Seq",     :null => false
    t.integer "Type",    :null => false
    t.integer "Id",      :null => false
  end

  create_table "status", :id => false, :force => true do |t|
    t.integer  "id",                                       :null => false
    t.integer  "bill_id",                                  :null => false
    t.datetime "StatusDate",                               :null => false
    t.string   "StatusCode", :limit => 10, :default => "", :null => false
    t.string   "AmSubDesc",  :limit => 10
  end

  create_table "versions", :id => false, :force => true do |t|
    t.integer "bill_id",                                   :null => false
    t.integer "number",                                    :null => false
    t.integer "version_id",                                :null => false
    t.string  "description", :limit => 50,                 :null => false
    t.string  "fileID",      :limit => 50, :default => "", :null => false
  end

  create_table "votes_detail", :id => false, :force => true do |t|
    t.integer "vote_id",                               :null => false
    t.string  "house",    :limit => 1, :default => "", :null => false
    t.integer "district",                              :null => false
    t.string  "vote",     :limit => 1, :default => "", :null => false
  end

  create_table "votes_master", :id => false, :force => true do |t|
    t.integer  "vote_id",                                   :null => false
    t.string   "house",       :limit => 1,  :default => "", :null => false
    t.datetime "date",                                      :null => false
    t.string   "type",        :limit => 2,  :default => ""
    t.integer  "num"
    t.string   "description", :limit => 60, :default => ""
    t.integer  "yea",                                       :null => false
    t.integer  "nay",                                       :null => false
    t.integer  "not_voting",                                :null => false
    t.integer  "excused",                                   :null => false
  end

end

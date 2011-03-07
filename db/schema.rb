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

  create_table "members", :force => true do |t|
    t.string  "last_name"
    t.string  "first_name"
    t.integer "district"
    t.string  "house",                        :limit => 1
    t.string  "party",                        :limit => 1
    t.string  "seat",                         :limit => 4
    t.string  "vote_id_string"
    t.integer "imsp_member_id"
    t.integer "total_instate_dollars"
    t.integer "total_out_of_state_dollars"
    t.integer "total_unknown_state_dollars"
    t.integer "party_committee_dollars"
    t.integer "leadership_committee_dollars"
    t.integer "candidate_money_dollars"
    t.integer "individual_dollars"
    t.integer "unitemized_donation_dollars"
    t.integer "non_contribution_dollars"
    t.integer "institution_dollars"
    t.integer "total_dollars"
  end

end

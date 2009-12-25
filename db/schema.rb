# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091005100041) do

  create_table "administrators", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
  end

  create_table "hours", :force => true do |t|
    t.string   "semester_type"
    t.integer  "week_hours"
    t.integer  "hourly_money"
    t.integer  "total_hours"
    t.date     "from"
    t.date     "to"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "student_number"
    t.string   "department"
    t.string   "id_number"
    t.string   "phone_number"
    t.text     "address"
    t.string   "post_office_account"
    t.string   "post_office_number"
    t.decimal  "school_score"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "post_office_name"
    t.string   "home_tel"
    t.string   "work_tel"
    t.string   "pt_type"
    t.string   "money_source"
    t.integer  "total_hours"
  end

  create_table "system_data_values", :force => true do |t|
    t.integer  "system_data_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_datas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

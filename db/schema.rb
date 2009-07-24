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

ActiveRecord::Schema.define(:version => 20090614194027) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assessments", :force => true do |t|
    t.integer  "value"
    t.integer  "answer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "round_id"
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", :force => true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "season_id"
    t.string   "name"
    t.boolean  "published"
    t.datetime "start_responses_at"
    t.datetime "end_responses_at"
    t.datetime "start_assess_at"
    t.datetime "end_assess_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rounds_count"
    t.integer  "questions_count"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "encrypted_password",        :limit => 128
    t.string   "token",                     :limit => 128
    t.datetime "token_expires_at"
    t.boolean  "email_confirmed",                          :default => false, :null => false
    t.boolean  "admin"
    t.boolean  "judge"
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "token"], :name => "index_users_on_id_and_token"
  add_index "users", ["judge"], :name => "index_users_on_judge"
  add_index "users", ["token"], :name => "index_users_on_token"

end

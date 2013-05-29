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

ActiveRecord::Schema.define(:version => 20130528003021) do

  create_table "feelings", :force => true do |t|
    t.integer  "user_id",         :null => false
    t.integer  "source_id",       :null => false
    t.string   "source_event_id", :null => false
    t.integer  "score",           :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "feelings", ["source_event_id"], :name => "index_feelings_on_source_event_id"
  add_index "feelings", ["source_id", "source_event_id"], :name => "index_feelings_on_source_id_and_source_event_id", :unique => true
  add_index "feelings", ["user_id"], :name => "index_feelings_on_user_id"

  create_table "phones", :force => true do |t|
    t.string   "number",                        :null => false
    t.boolean  "verified",   :default => false, :null => false
    t.integer  "user_id",                       :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "phones", ["number", "verified"], :name => "index_phones_on_number_and_verified", :unique => true
  add_index "phones", ["verified"], :name => "index_phones_on_verified"

  create_table "sources", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "key",        :null => false
    t.string   "secret",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sources", ["key"], :name => "index_sources_on_key", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                           :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end

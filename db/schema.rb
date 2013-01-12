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

ActiveRecord::Schema.define(:version => 20130112100949) do

  create_table "replies", :force => true do |t|
    t.text     "content"
    t.integer  "author_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "replies", ["author_id"], :name => "index_replies_on_author_id"
  add_index "replies", ["topic_id"], :name => "index_replies_on_topic_id"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.integer  "last_reply_id"
    t.integer  "last_reply_author_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "topics", ["author_id"], :name => "index_topics_on_author_id"
  add_index "topics", ["last_reply_author_id"], :name => "index_topics_on_last_reply_author_id"
  add_index "topics", ["last_reply_id"], :name => "index_topics_on_last_reply_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "persistence_token"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end

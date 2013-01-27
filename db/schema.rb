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

ActiveRecord::Schema.define(:version => 20130127175021) do

  create_table "read_marks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "reply_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "read_marks", ["reply_id"], :name => "index_read_marks_on_reply_id"
  add_index "read_marks", ["topic_id"], :name => "index_read_marks_on_topic_id"
  add_index "read_marks", ["user_id"], :name => "index_read_marks_on_user_id"

  create_table "replies", :force => true do |t|
    t.text     "content"
    t.integer  "author_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "replies", ["author_id"], :name => "index_replies_on_author_id"
  add_index "replies", ["topic_id"], :name => "index_replies_on_topic_id"

  create_table "scores", :force => true do |t|
    t.string   "scorable_type"
    t.integer  "scorable_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "scores", ["scorable_type", "scorable_id", "user_id"], :name => "index_scores_on_scorable_type_and_scorable_id_and_user_id", :unique => true
  add_index "scores", ["scorable_type", "scorable_id"], :name => "index_scores_on_scorable_type_and_scorable_id"
  add_index "scores", ["user_id"], :name => "index_scores_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["topic_id"], :name => "index_taggings_on_topic_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.integer  "last_reply_id"
    t.integer  "last_reply_author_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.datetime "last_activity_at"
    t.integer  "replies_count",        :default => 0, :null => false
  end

  add_index "topics", ["author_id"], :name => "index_topics_on_author_id"
  add_index "topics", ["last_reply_author_id"], :name => "index_topics_on_last_reply_author_id"
  add_index "topics", ["last_reply_id"], :name => "index_topics_on_last_reply_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "persistence_token"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "trusted",           :default => false, :null => false
  end

end

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

ActiveRecord::Schema.define(:version => 20111129184807) do

  create_table "comments", :force => true do |t|
    t.string   "name",       :limit => 100,                    :null => false
    t.string   "email",      :limit => 100,                    :null => false
    t.string   "url",                                          :null => false
    t.boolean  "active",                    :default => false, :null => false
    t.string   "body",                                         :null => false
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "posts", :force => true do |t|
    t.string   "title",          :limit => 250,                   :null => false
    t.string   "excerpt",        :limit => 250
    t.text     "body",                                            :null => false
    t.boolean  "allow_comments",                :default => true, :null => false
    t.integer  "user_id",                                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "users", :force => true do |t|
    t.string "name",     :null => false
    t.string "email",    :null => false
    t.string "password", :null => false
  end

end

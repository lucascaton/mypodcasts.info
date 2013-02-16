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

ActiveRecord::Schema.define(:version => 20130216014009) do

  create_table "podcasts", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "feed_url"
    t.string   "itunes_url"
    t.boolean  "active",            :default => false, :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "created_by_id",                        :null => false
    t.text     "overview"
    t.string   "slug"
  end

  add_index "podcasts", ["feed_url"], :name => "index_podcasts_on_feed_url", :unique => true
  add_index "podcasts", ["itunes_url"], :name => "index_podcasts_on_itunes_url", :unique => true
  add_index "podcasts", ["name"], :name => "index_podcasts_on_name", :unique => true
  add_index "podcasts", ["slug"], :name => "index_podcasts_on_slug", :unique => true

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "podcast_id", :null => false
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "subscriptions", ["user_id", "podcast_id"], :name => "index_subscriptions_on_user_id_and_podcast_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

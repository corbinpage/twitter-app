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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140418183312) do

  create_table "beverage_tweets", force: true do |t|
    t.integer  "beverage_id"
    t.integer  "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beverage_tweets", ["beverage_id"], name: "index_beverage_tweets_on_beverage_id"
  add_index "beverage_tweets", ["tweet_id"], name: "index_beverage_tweets_on_tweet_id"

  create_table "beverages", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "scans", force: true do |t|
    t.integer  "score"
    t.string   "error"
    t.float    "average_sentiment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  add_index "scans", ["category"], name: "index_scans_on_category"

  create_table "tweets", force: true do |t|
    t.text     "text"
    t.string   "twitter_id"
    t.datetime "tweet_time"
    t.integer  "score"
    t.integer  "scan_id"
    t.float    "sentiment_score"
    t.string   "sentiment_summary"
    t.text     "html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_geo"
    t.float    "lat"
    t.float    "lng"
    t.string   "country"
  end

  add_index "tweets", ["created_at"], name: "index_tweets_on_created_at"
  add_index "tweets", ["scan_id"], name: "index_tweets_on_scan_id"
  add_index "tweets", ["twitter_id"], name: "index_tweets_on_twitter_id"

  create_table "word_tweets", force: true do |t|
    t.integer  "tweet_id"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "word_tweets", ["tweet_id"], name: "index_word_tweets_on_tweet_id"
  add_index "word_tweets", ["word_id"], name: "index_word_tweets_on_word_id"

  create_table "word_types", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "word_types", ["text"], name: "index_word_types_on_text"

  create_table "words", force: true do |t|
    t.string   "text"
    t.integer  "word_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "words", ["text"], name: "index_words_on_text"

end

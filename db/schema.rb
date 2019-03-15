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

ActiveRecord::Schema.define(version: 20190222101244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "body"
    t.integer "question_id"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "num_initial_upvotes", default: 0
    t.index ["author_id"], name: "index_answers_on_author_id"
    t.index ["question_id", "author_id"], name: "index_answers_on_question_id_and_author_id", unique: true
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "partner_auths", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.text "auth_json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "provider"], name: "index_partner_auths_on_user_id_and_provider", unique: true
    t.index ["user_id"], name: "index_partner_auths_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "body", null: false
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "num_initial_follows", default: 0
    t.index ["author_id", "body"], name: "index_questions_on_author_id_and_body", unique: true
    t.index ["author_id"], name: "index_questions_on_author_id"
  end

  create_table "questions_topics", force: :cascade do |t|
    t.integer "topic_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "topic_id"], name: "index_questions_topics_on_question_id_and_topic_id", unique: true
    t.index ["question_id"], name: "index_questions_topics_on_question_id"
    t.index ["topic_id"], name: "index_questions_topics_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "num_initial_follows", default: 0
    t.string "pic_url"
  end

  create_table "topics_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "topic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id", "user_id"], name: "index_topics_users_on_topic_id_and_user_id", unique: true
    t.index ["topic_id"], name: "index_topics_users_on_topic_id"
    t.index ["user_id"], name: "index_topics_users_on_user_id"
  end

  create_table "user_whitelists", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_whitelists_on_email"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "name"
    t.string "pro_pic_url", default: "https://graph.facebook.com/123/picture"
    t.string "fb_id"
    t.string "google_id"
    t.string "given_name"
    t.string "last_name"
    t.string "access_token"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["google_id"], name: "index_users_on_google_id", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "partner_auths", "users"
end

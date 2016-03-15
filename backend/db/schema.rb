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

ActiveRecord::Schema.define(version: 20160309163916) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "tag_id",     null: false
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["tag_id", "user_id"], name: "index_messages_on_tag_id_and_user_id"
  add_index "messages", ["tag_id"], name: "index_messages_on_tag_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "reported_status_updates", force: :cascade do |t|
    t.integer  "status_update_id"
    t.string   "reason"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "reported_status_updates", ["status_update_id"], name: "index_reported_status_updates_on_status_update_id"

  create_table "services", force: :cascade do |t|
    t.string   "uid",         null: false
    t.string   "auth_token"
    t.string   "auth_secret"
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "provider"
  end

  add_index "services", ["provider", "uid"], name: "index_services_on_provider_and_uid"
  add_index "services", ["user_id"], name: "index_services_on_user_id"

  create_table "status_updates", force: :cascade do |t|
    t.string   "identity",                       null: false
    t.string   "provider",                       null: false
    t.string   "media_uri"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "content_type", default: "image"
  end

  create_table "tag_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tag_status_updates", force: :cascade do |t|
    t.integer  "status_update_id", null: false
    t.integer  "tag_id",           null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "tag_status_updates", ["status_update_id"], name: "index_tag_status_updates_on_status_update_id"
  add_index "tag_status_updates", ["tag_id", "status_update_id"], name: "index_tag_status_updates_on_tag_id_and_status_update_id"
  add_index "tag_status_updates", ["tag_id"], name: "index_tag_status_updates_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "title",                                           null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "tag_category_id"
    t.datetime "active_as_of"
    t.text     "type"
    t.integer  "count"
    t.integer  "views",           default: 0,                     null: false
    t.datetime "expires_at",      default: '1970-01-01 00:00:00', null: false
    t.boolean  "hidden",          default: false,                 null: false
  end

  add_index "tags", ["active_as_of"], name: "index_tags_on_active_as_of"
  add_index "tags", ["expires_at"], name: "index_tags_on_expires_at"
  add_index "tags", ["hidden"], name: "index_tags_on_hidden"

  create_table "user_tag_categories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tag_category_id"
    t.integer  "tag_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "user_tag_categories", ["tag_category_id"], name: "index_user_tag_categories_on_tag_category_id"
  add_index "user_tag_categories", ["tag_id"], name: "index_user_tag_categories_on_tag_id"
  add_index "user_tag_categories", ["user_id"], name: "index_user_tag_categories_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "screen_name",                            null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "avatar_url"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "gender"
    t.date     "date_of_birth"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

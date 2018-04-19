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

ActiveRecord::Schema.define(version: 20171031010944) do

  create_table "attachments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "attachments_examples", id: false, force: :cascade do |t|
    t.string "attachment_id"
    t.string "example_id"
  end

  create_table "attachments_snippets", id: false, force: :cascade do |t|
    t.string "attachment_id"
    t.string "snippet_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "example_versions", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "example_id"
    t.integer  "version_id_start"
    t.integer  "version_id_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examples", force: :cascade do |t|
    t.string   "example_type"
    t.text     "documentation"
    t.string   "title"
    t.boolean  "is_method"
    t.text     "code"
    t.string   "created_by"
    t.string   "edited_by"
    t.boolean  "vbs"
    t.boolean  "asp"
    t.boolean  "php"
    t.boolean  "cfm"
    t.boolean  "cs"
    t.boolean  "vb"
    t.boolean  "rb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "clone_id"
    t.string   "status",               default: "in progress"
    t.text     "legacy_documentation"
    t.string   "video"
    t.text     "description"
    t.boolean  "ps1"
    t.string   "department"
    t.boolean  "html"
    t.boolean  "shell"
    t.text     "display_title"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "content"
    t.integer  "rating"
    t.string   "from_name"
    t.string   "from_email"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "human_check"
  end

  create_table "hits", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snippet_versions", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "snippet_id"
    t.integer  "version_id_start"
    t.integer  "version_id_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snippets", force: :cascade do |t|
    t.string   "name"
    t.text     "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "qa",                     default: false
    t.boolean  "admin",                  default: false
    t.boolean  "support",                default: false
    t.boolean  "engineering",            default: false
    t.string   "token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "name"
    t.integer  "product_id"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "documentation_url"
    t.string   "status"
    t.string   "builds"
    t.string   "dll_paths"
    t.string   "namespace"
    t.string   "class_name"
    t.string   "docs_url"
    t.string   "com_object"
    t.string   "object_name"
    t.boolean  "use_dispose"
    t.boolean  "beta"
  end

end

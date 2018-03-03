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

ActiveRecord::Schema.define(version: 20170924192656) do

  create_table "cms_languages", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "title", limit: 250
    t.string "lang", limit: 4
    t.boolean "enabled", default: true, null: false, unsigned: true
    t.string "charset", limit: 15, default: "utf8_unicode_ci", null: false
    t.string "locale", null: false
    t.string "lang_html", limit: 10, null: false
    t.integer "pos", null: false
    t.string "countries", null: false
    t.index ["lang"], name: "idxLang", unique: true
  end

  create_table "cms_mediafiles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "media_type"
    t.string "path"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "cms_pages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0" do |t|
    t.string "title", null: false
    t.string "name"
    t.string "url"
    t.integer "url_parts_count", limit: 1, default: 0, null: false, unsigned: true
    t.integer "url_vars_count", limit: 1, default: 0, null: false, unsigned: true
    t.string "parsed_url"
    t.integer "parent_id", default: 0
    t.string "view_path"
    t.boolean "is_translated", default: false, null: false, unsigned: true
    t.integer "status", default: 0, null: false
    t.integer "pos", default: 0, null: false
    t.string "redir_url"
    t.integer "template_id"
    t.integer "layout_id"
    t.integer "owner"
    t.boolean "is_folder", default: false, null: false, unsigned: true
    t.string "controller_action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "enabled", limit: 1, default: 1, null: false, unsigned: true
    t.index ["name"], name: "index_cms_pages_on_name"
    t.index ["parent_id"], name: "parent_id"
    t.index ["status"], name: "status"
    t.index ["url"], name: "url"
  end

  create_table "cms_pages_translation", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0" do |t|
    t.integer "item_id", default: 0, null: false, unsigned: true
    t.integer "page_id"
    t.string "lang", limit: 5, null: false
    t.string "meta_title"
    t.text "meta_description"
    t.string "meta_keywords"
    t.string "template_filename"
    t.index ["item_id"], name: "item_id"
    t.index ["lang"], name: "lang"
    t.index ["template_filename"], name: "template"
  end

  create_table "cms_templates", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0" do |t|
    t.string "title", null: false
    t.string "name"
    t.string "basename", null: false
    t.string "basepath", null: false
    t.string "basedirpath", null: false
    t.integer "type_id", limit: 1
    t.string "tpl_format"
    t.integer "pos"
    t.boolean "is_translated", default: false, null: false, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_folder", default: false, null: false
    t.boolean "enabled", default: true, null: false, unsigned: true
    t.string "ancestry"
    t.index ["ancestry"], name: "ancestry"
    t.index ["basepath"], name: "basepath"
    t.index ["pos"], name: "pos"
  end

  create_table "cms_templates_translation", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "item_id", null: false, unsigned: true
    t.string "lang", limit: 5, null: false
    t.index ["item_id", "lang"], name: "item_id", unique: true
  end

  create_table "cms_templatetypes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.string "title"
    t.integer "pos", null: false
  end

  create_table "cms_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.boolean "is_superadmin", default: false, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_optimacms_cms_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_optimacms_cms_users_on_reset_password_token", unique: true
  end

  create_table "optimacms_articles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optimacms_cms_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_optimacms_cms_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_optimacms_cms_users_on_reset_password_token", unique: true
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

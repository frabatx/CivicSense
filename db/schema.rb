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

ActiveRecord::Schema.define(version: 2018_06_12_180848) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "administrations", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number", null: false
    t.string "city", null: false
    t.string "province", null: false
    t.string "street", null: false
    t.integer "user_id", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "screams", id: :string, force: :cascade do |t|
    t.float "latitude", default: 0.0, null: false
    t.float "longitude", default: 0.0, null: false
    t.string "address"
    t.string "description", null: false
    t.integer "priority", default: 1
    t.string "screamer_email"
    t.integer "status", default: 1
    t.integer "category_id", null: false
    t.integer "solver_id"
    t.integer "administration_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "sqlite_autoindex_screams_1", unique: true
  end

  create_table "solvers", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.string "phone_number", null: false
    t.integer "user_id", null: false
    t.integer "administration_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 1, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_03_082523) do

  create_table "bin_reports", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "source_file_id", null: false
    t.string "time", null: false
    t.string "name", null: false
    t.string "model", null: false
    t.string "sn", null: false
    t.float "current", null: false
    t.string "bin", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sn"], name: "index_bin_reports_on_sn"
    t.index ["source_file_id"], name: "index_bin_reports_on_source_file_id"
  end

  create_table "search_histories", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "time"
    t.string "name"
    t.string "model"
    t.string "sn", null: false
    t.float "current"
    t.string "bin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sn"], name: "index_search_histories_on_sn"
  end

  create_table "source_files", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "file_name", null: false
    t.integer "total_row", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["file_name"], name: "index_source_files_on_file_name", unique: true
  end

end

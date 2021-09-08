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

ActiveRecord::Schema.define(version: 2020_05_19_122413) do

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

  create_table "click_responses", force: :cascade do |t|
    t.integer "participant_id"
    t.float "time"
    t.string "answer"
    t.integer "click_task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "no_clicks_explanation", default: false
    t.boolean "from_checkbox", default: false
    t.index ["click_task_id"], name: "index_click_responses_on_click_task_id"
  end

  create_table "click_tasks", force: :cascade do |t|
    t.text "prompt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "experiments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.boolean "complete", default: false
    t.string "slug"
    t.text "terms"
    t.index ["slug"], name: "index_experiments_on_slug", unique: true
    t.index ["user_id"], name: "index_experiments_on_user_id"
  end

  create_table "listening_tasks", force: :cascade do |t|
    t.integer "listens", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "options", force: :cascade do |t|
    t.string "contents"
    t.string "chooseable_type"
    t.integer "chooseable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chooseable_type", "chooseable_id"], name: "index_options_on_chooseable_type_and_chooseable_id"
  end

  create_table "question_tasks", force: :cascade do |t|
  end

  create_table "questions", force: :cascade do |t|
    t.text "prompt"
    t.string "type"
    t.integer "question_task_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sort"
    t.index ["question_task_id"], name: "index_questions_on_question_task_id"
  end

  create_table "researcher_invitations", force: :cascade do |t|
    t.string "registration_code"
    t.boolean "used", default: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_researcher_invitations_on_user_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string "answer"
    t.integer "participant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "question_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
  end

  create_table "sample_tasks", force: :cascade do |t|
    t.boolean "calibration", default: false
  end

  create_table "scales", force: :cascade do |t|
    t.integer "bins"
    t.string "high"
    t.string "low"
    t.integer "rating_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rating_id"], name: "index_scales_on_rating_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "actable_type"
    t.integer "actable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "taskable_type"
    t.integer "taskable_id"
    t.integer "sort"
    t.boolean "random", default: false
    t.index ["actable_type", "actable_id"], name: "index_tasks_on_actable_type_and_actable_id"
    t.index ["taskable_type", "taskable_id"], name: "index_tasks_on_taskable_type_and_taskable_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "institution"
    t.string "country"
    t.string "faculty"
    t.string "research_level"
    t.boolean "funded"
    t.boolean "mailing_list"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.integer "participant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "task_id"
    t.boolean "visited", default: false
    t.index ["task_id"], name: "index_visits_on_task_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "click_responses", "click_tasks"
  add_foreign_key "responses", "questions"
  add_foreign_key "visits", "tasks"
end

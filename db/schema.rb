# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_22_012529) do
  create_table "action_instances", force: :cascade do |t|
    t.integer "action_template_id", null: false
    t.integer "task_instance_id", null: false
    t.string "description"
    t.integer "target"
    t.string "target_type"
    t.integer "progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_template_id"], name: "index_action_instances_on_action_template_id"
    t.index ["task_instance_id"], name: "index_action_instances_on_task_instance_id"
  end

  create_table "action_templates", force: :cascade do |t|
    t.integer "task_template_id", null: false
    t.string "description"
    t.integer "target"
    t.string "target_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_template_id"], name: "index_action_templates_on_task_template_id"
  end

  create_table "task_instances", force: :cascade do |t|
    t.string "state"
    t.date "start_date"
    t.date "due_date"
    t.string "description"
    t.string "reminder_time"
    t.integer "task_template_id", null: false
    t.string "goal_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_template_id"], name: "index_task_instances_on_task_template_id"
  end

  create_table "task_templates", force: :cascade do |t|
    t.date "first_date"
    t.date "end_date"
    t.string "description"
    t.integer "repeat_days"
    t.boolean "active"
    t.string "reminder_time"
    t.string "task_category_id"
    t.string "goal_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "action_instances", "action_templates"
  add_foreign_key "action_instances", "task_instances"
  add_foreign_key "action_templates", "task_templates"
  add_foreign_key "task_instances", "task_templates"
end

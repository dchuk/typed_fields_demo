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

ActiveRecord::Schema[8.1].define(version: 2026_04_23_044336) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "typed_field_options", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "field_id", null: false
    t.string "label", null: false
    t.integer "sort_order"
    t.datetime "updated_at", null: false
    t.string "value", null: false
    t.index ["field_id", "value"], name: "idx_tf_options_field_value", unique: true
    t.index ["field_id"], name: "index_typed_field_options_on_field_id"
  end

  create_table "typed_field_sections", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.string "entity_type", null: false
    t.string "name", null: false
    t.string "scope"
    t.integer "sort_order"
    t.datetime "updated_at", null: false
    t.index ["entity_type", "active"], name: "idx_tf_sections_entity_active"
    t.index ["entity_type", "code", "scope"], name: "idx_tf_sections_unique", unique: true
  end

  create_table "typed_field_values", force: :cascade do |t|
    t.boolean "boolean_value"
    t.datetime "created_at", null: false
    t.date "date_value"
    t.datetime "datetime_value"
    t.decimal "decimal_value", precision: 30, scale: 10
    t.bigint "entity_id", null: false
    t.string "entity_type", null: false
    t.bigint "field_id", null: false
    t.bigint "integer_value"
    t.jsonb "json_value"
    t.text "string_value"
    t.text "text_value"
    t.datetime "updated_at", null: false
    t.index ["entity_type", "entity_id", "field_id"], name: "idx_tf_values_entity_field", unique: true
    t.index ["entity_type", "entity_id"], name: "index_typed_field_values_on_entity"
    t.index ["field_id", "boolean_value"], name: "idx_tf_values_field_bool", include: ["entity_id", "entity_type"]
    t.index ["field_id", "date_value"], name: "idx_tf_values_field_date", include: ["entity_id", "entity_type"]
    t.index ["field_id", "datetime_value"], name: "idx_tf_values_field_dt", include: ["entity_id", "entity_type"]
    t.index ["field_id", "decimal_value"], name: "idx_tf_values_field_dec", include: ["entity_id", "entity_type"]
    t.index ["field_id", "integer_value"], name: "idx_tf_values_field_int", include: ["entity_id", "entity_type"]
    t.index ["field_id", "string_value"], name: "idx_tf_values_field_str", opclass: { string_value: :text_pattern_ops }, include: ["entity_id", "entity_type"]
    t.index ["field_id"], name: "index_typed_field_values_on_field_id"
  end

  create_table "typed_fields", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "default_value_meta", default: {}, null: false
    t.string "entity_type", null: false
    t.string "name", null: false
    t.jsonb "options", default: {}, null: false
    t.boolean "required", default: false, null: false
    t.string "scope"
    t.bigint "section_id"
    t.integer "sort_order"
    t.string "type", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_type"], name: "index_typed_fields_on_entity_type"
    t.index ["name", "entity_type", "scope"], name: "idx_tf_fields_unique", unique: true
    t.index ["section_id"], name: "index_typed_fields_on_section_id"
  end

  add_foreign_key "typed_field_options", "typed_fields", column: "field_id", on_delete: :cascade
  add_foreign_key "typed_field_values", "typed_fields", column: "field_id", on_delete: :cascade
  add_foreign_key "typed_fields", "typed_field_sections", column: "section_id", on_delete: :nullify
end

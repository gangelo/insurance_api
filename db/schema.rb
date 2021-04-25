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

ActiveRecord::Schema.define(version: 2021_04_22_194323) do

  create_table "agent_carriers", id: false, force: :cascade do |t|
    t.integer "agent_id"
    t.integer "carrier_id"
    t.index ["agent_id"], name: "index_agent_carriers_on_agent_id"
    t.index ["carrier_id"], name: "index_agent_carriers_on_carrier_id"
  end

  create_table "agent_policies", force: :cascade do |t|
    t.integer "agent_id"
    t.integer "policy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agent_id"], name: "index_agent_policies_on_agent_id"
    t.index ["policy_id"], name: "index_agent_policies_on_policy_id"
  end

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carrier_industries", id: false, force: :cascade do |t|
    t.integer "carrier_id"
    t.integer "industry_id"
    t.index ["carrier_id"], name: "index_carrier_industries_on_carrier_id"
    t.index ["industry_id"], name: "index_carrier_industries_on_industry_id"
  end

  create_table "carriers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "licenses", force: :cascade do |t|
    t.string "state"
    t.integer "agent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_licenses_on_agent_id"
  end

  create_table "policies", force: :cascade do |t|
    t.string "policy_holder"
    t.decimal "premium_amount", precision: 5, scale: 2
    t.integer "carrier_id"
    t.integer "industry_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["carrier_id"], name: "index_policies_on_carrier_id"
    t.index ["industry_id"], name: "index_policies_on_industry_id"
  end

  add_foreign_key "agent_carriers", "agents"
  add_foreign_key "agent_carriers", "carriers"
  add_foreign_key "agent_policies", "agents"
  add_foreign_key "agent_policies", "policies"
  add_foreign_key "carrier_industries", "carriers"
  add_foreign_key "carrier_industries", "industries"
  add_foreign_key "licenses", "agents"
  add_foreign_key "policies", "carriers"
  add_foreign_key "policies", "industries"
end

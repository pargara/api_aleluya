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

ActiveRecord::Schema[7.0].define(version: 2023_04_12_145206) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "phone"
    t.string "direction"
    t.string "mail", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "payroll_period_id", null: false
    t.string "name", null: false
    t.integer "document_identity", null: false
    t.integer "base_salary", null: false
    t.float "percentage_of_social_security"
    t.float "percentage_of_pension_fund"
    t.float "percentage_arl"
    t.float "solidarity_fund"
    t.float "subsistence_fund"
    t.integer "total_deductions"
    t.integer "non_salary_income"
    t.integer "other_salary_income"
    t.integer "other_deductions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payroll_period_id"], name: "index_employees_on_payroll_period_id"
  end

  create_table "payroll_periods", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.float "percentage_of_social_security"
    t.float "percentage_of_pension_fund"
    t.float "compensation"
    t.float "icbf"
    t.float "sena"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "minimum_salary"
    t.integer "transport_subsidy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_payroll_periods_on_company_id"
  end

  create_table "payrolls", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.float "cost_employee"
    t.float "payroll_employee"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_payrolls_on_employee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "companies", "users"
  add_foreign_key "employees", "payroll_periods"
  add_foreign_key "payroll_periods", "companies"
  add_foreign_key "payrolls", "employees"
end

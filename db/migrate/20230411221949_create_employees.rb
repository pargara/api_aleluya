class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.belongs_to :payroll_period, null: false, foreign_key: true
      t.string :base_salary, null: false
      t.float :percentage_of_social_security, default: 4
      t.float :percentage_of_pension_fund, default: 4
      t.integer :total_deductions
      t.integer :non_salary_income
      t.integer :other_salary_income
      t.integer :other_dedections

      t.timestamps
    end
  end
end

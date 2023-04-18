class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.belongs_to :payroll_period, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :document_identity, null: false
      t.integer :base_salary, null: false
      t.float :percentage_of_social_security
      t.float :percentage_of_pension_fund
      t.float :solidarity_fund
      t.float :subsistence_fund
      t.integer :total_deductions
      t.integer :non_salary_income
      t.integer :other_salary_income
      t.integer :other_deductions

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreatePayrollPeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :payroll_periods do |t|
      t.belongs_to :company, null: false, foreign_key: true
      t.float :percentage_of_social_security
      t.float :percentage_of_pension_fund
      t.float :compensation
      t.float :icbf
      t.float :sena
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :minimum_salary
      t.integer :transport_subsidy

      t.timestamps
    end
  end
end

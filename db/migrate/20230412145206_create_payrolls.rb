class CreatePayrolls < ActiveRecord::Migration[7.0]
  def change
    create_table :payrolls do |t|
      t.belongs_to :employee, null: false, foreign_key: true
      t.float :total_deductions
      t.float :total_payroll
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end

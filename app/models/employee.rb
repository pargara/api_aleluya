class Employee < ApplicationRecord
  include SetDefaultValues

  before_create :set_employee_values

  belongs_to :payroll_period
  has_many :payrolls
	
	validates :salary presence: true
end

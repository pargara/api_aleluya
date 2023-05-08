# frozen_string_literal: true

class Employee < ApplicationRecord
  include SetDefaultValues

  before_create :set_employee_values

  belongs_to :payroll_period
  has_many :payrolls

  validates :base_salary, presence: true
  validates :name, presence: true
  validates :document_identity, presence: true
end

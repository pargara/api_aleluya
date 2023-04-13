class PayrollPeriod < ApplicationRecord
  include SetDefaultValues

  before_create :set_payroll_period_values

  belongs_to :company
	has_many :employees

	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :start_date, :end_date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "El formato debe de ser (YYYY-MM-DD)" }
end

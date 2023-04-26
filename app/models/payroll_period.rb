# frozen_string_literal: true

class PayrollPeriod < ApplicationRecord
  include SetDefaultValues

  before_create :set_payroll_period_values

  belongs_to :company
  has_many :employees, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_date, :end_date,
            format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'El formato debe de ser (YYYY-MM-DD)' }
  validate :validate_date_range

  private

  def validate_date_range
    @period = start_date..end_date
    @range = 28..31
    if !@range.include?(@period.count)
      errors.add(:end_date, "must be at least 28 days after start date")
    end
  end
end

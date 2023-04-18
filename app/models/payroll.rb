class Payroll < ApplicationRecord
  belongs_to :employee

  before_save :call_service

  validates :start_date, presence: true
  validates :end_date, presence: true

  private
  
  def call_service
    service = PayrollService.new(self)
  end
end

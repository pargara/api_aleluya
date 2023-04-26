# frozen_string_literal: true

class Payroll < ApplicationRecord
  include SetDefaultValues

  belongs_to :employee

  before_create :set_payroll_values
  before_create :call_service


  private

  def call_service
    service = PayrollService.new(self)
  end
end

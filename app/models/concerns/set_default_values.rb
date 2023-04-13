module SetDefaultValues
  extend ActiveSupport::Concern

  # included do
  #   after_create :do_something
  # end

  def set_payroll_period_values
    self.percentage_of_social_security = 8.5
    self.percentage_of_pension_fund = 12
    self.minimum_salary = 1160000
    self.transport_subsidy = 140000
  end

  def set_employee_values
    self.percentage_of_social_security = 4
    self.percentage_of_pension_fund = 4
  end

  def set_payroll_values
    self.total_payroll = method_from_service
    self.total_deductions = method_from_service
  end
end

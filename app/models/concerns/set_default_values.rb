# frozen_string_literal: true

module SetDefaultValues
  extend ActiveSupport::Concern

  def set_payroll_period_values
    self.percentage_of_social_security = 8.5
    self.percentage_of_pension_fund = 12
    self.minimum_salary = 1_160_000
    self.transport_subsidy = 140_000
  end

  def set_employee_values
    self.percentage_of_social_security = 4
    self.percentage_of_pension_fund = 4
    self.solidarity_fund = 1

    @salaries = non_salary_income ? (non_salary_income * base_salary) / payroll_period.minimum_salary : base_salary / payroll_period.minimum_salary

    set_subsistence_fund(@salaries)
    set_solidarity_fund(@salaries)
  end

  def set_payroll_values
    self.start_date = self.employee.payroll_period.start_date
    self.end_date = self.employee.payroll_period.end_date
  end

  def set_subsistence_fund(salaries)
    # @salaries = (self.base_salary * self.non_salary_income) / self.payroll_period.minimum_salary
    self.subsistence_fund = case @salaries
                            when 0..16
                              0
                            when 17
                              0.002
                            when 18
                              0.004
                            when 19
                              0.006
                            when 20
                              0.008
                            else
                              1
                            end
  end

  def set_arl(risk = 'I')
    case risk
    when 'I'
      self.percentage_arl = 0.522
    when 'II'
      self.percentage_arl = 1.044
    when 'III'
      self.percentage_arl = 2.436
    when 'IV'
      self.percentage_arl = 4.350
    when 'V'
      self.percentage_arl = 6.960
    end
  end

  def set_solidarity_fund(salaries)
    if salaries >= 4
      self.solidarity_fund = 1
    else
      self.solidarity_fund = 0
    end
  end
end

module SetDefaultValues
  extend ActiveSupport::Concern

  def set_payroll_period_values
    self.percentage_of_social_security = 8.5
    self.percentage_of_pension_fund = 12
    self.minimum_salary = 1160000
    self.transport_subsidy = 140000

    set_arl
  end

  def set_employee_values
    self.percentage_of_social_security = 4
    self.percentage_of_pension_fund = 4
    self.solidarity_fund = 1

    set_subsistence_fund
  end

  def set_payroll_values
    self.total_payroll = method_from_service
    self.total_deductions = method_from_service
  end

  def set_subsistence_fund
    @salaries = self.non_salary_income ? (self.non_salary_income * self.base_salary) / self.payroll_period.minimum_salary : self.base_salary / self.payroll_period.minimum_salary

    # @salaries = (self.base_salary * self.non_salary_income) / self.payroll_period.minimum_salary
    case @salaries
    when 0..16
      self.subsistence_fund = 0
    when 17
      self.subsistence_fund = 0.002
    when 18
      self.subsistence_fund = 0.004
    when 19
      self.subsistence_fund = 0.006
    when 20
      self.subsistence_fund = 0.008
    else
      self.subsistence_fund = 1
    end
  end
  
  def set_arl(risk = "I")
    case risk
    when "I"
      self.percentage_arl = 0.522
    when "II"
      self.percentage_arl = 1.044
    when "III"
      self.percentage_arl = 2.436
    when "IV"
      self.percentage_arl = 4.350
    when "V"
      self.percentage_arl = 6.960
    end
  end
end

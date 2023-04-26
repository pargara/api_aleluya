# frozen_string_literal: true

json.data do
  current_user.companies.each do |company|
    company.payroll_periods.each do |payroll_period|
      json.array! payroll_period.employees do |employee|
        json.employee_id employee.id
        json.name employee.name
        json.document_of_identity employee.document_identity
        json.base_salary employee.base_salary
        json.total_deductions employee.total_deductions
        json.non_salary_income employee.non_salary_income
        json.other_salary_income employee.other_salary_income
        json.other_deductions employee.other_deductions
      end
    end
  end
end

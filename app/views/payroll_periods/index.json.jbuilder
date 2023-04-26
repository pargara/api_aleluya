# frozen_string_literal: true

json.data do
	@companies.each do |company|
		json.array! company.payroll_periods do |period|
			json.company_name period.company.name
			json.start_date period.start_date
			json.end_date period.end_date
			binding.break
			json.payrolls period.employees do |employee|
				json.payroll_id employee.payroll.id
				json.employee_name employee.payroll.employee.name
				json.employee_id employee.payroll.employee.id
				json.payroll_employee employee.payroll.payroll_employee
				json.cost_employee employee.payroll.cost_employee
			end
		end
	end
end

# frozen_string_literal: true

json.data do
	json.array! @payrolls do |payroll|
		json.id payroll.id
		json.employee_id payroll.employee.id
		json.employee payroll.employee.name
		json.start_date payroll.start_date
		json.end_date payroll.end_date
		json.payroll_employee payroll.payroll_employee
		json.cost_employee payroll.cost_employee
	end
end

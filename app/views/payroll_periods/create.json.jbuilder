json.data do
	json.name @payroll_period.start_date
	json.phone @payroll_period.end_date
	json.company_id @payroll_period.company_id
	json.company_name @payroll_period.company.name
end

json.data do
  json.array! @payroll_periods do |period|
    json.company_name period.company.name
    json.start_date period.start_date
    json.end_date period.end_date
  end
end

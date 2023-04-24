# frozen_string_literal: true

json.data do
  json.id @employee.id
  json.name @employee.name
  json.document_identity @employee.document_identity
  json.base_salary @employee.base_salary
  json.payroll_period @employee.payroll_period_id
end

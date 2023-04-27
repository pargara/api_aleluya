require "test_helper"
require_relative '../helpers/authorization_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @employee = employees(:employee_one)
    test_user = { email: 'user@test.com', password: 'testuser' }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get employees_url, headers: @auth_tokens, as: :json
    assert_response :success
  end

  test "should create employee" do
    assert_difference("Employee.count") do
      post employees_url, params: { employee: { name: @employee.name, document_identity: @employee.document_identity, base_salary: @employee.base_salary, other_deductions: @employee.other_deductions, payroll_period_id: @employee.payroll_period_id, percentage_of_pension_fund: @employee.percentage_of_pension_fund, percentage_of_social_security: @employee.percentage_of_social_security, total_deductions: @employee.total_deductions} }, headers: @auth_tokens, as: :json
    end

    assert_response :created
  end

  test "should show employee" do
    get employee_url(@employee), headers: @auth_tokens, as: :json
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { name: @employee.name, document_identity: @employee.document_identity, base_salary: @employee.base_salary, other_deductions: @employee.other_deductions, payroll_period_id: @employee.payroll_period_id, percentage_of_pension_fund: @employee.percentage_of_pension_fund, percentage_of_social_security: @employee.percentage_of_social_security, total_deductions: @employee.total_deductions} }, headers: @auth_tokens, as: :json
    assert_response :success
  end

  test "should destroy employee" do
    assert_difference("Employee.count", -1) do
      delete employee_url(@employee), headers: @auth_tokens, as: :json
    end

    assert_response :no_content
  end
end

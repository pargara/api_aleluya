# frozen_string_literal: true

require 'test_helper'
require_relative '../helpers/authorization_helper'

class PayrollsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @payroll = payrolls(:payroll_one)
    test_user = { email: 'user@test.com', password: 'testuser' }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)

  end

  test 'should get index' do
    get payrolls_url, headers: @auth_tokens, as: :json

    assert_response :success
  end

  test 'should create payroll' do
    assert_difference('Payroll.count') do
      post payrolls_url,
           params: { payroll: { employee_id: @payroll.employee_id, end_date: @payroll.end_date, start_date: @payroll.start_date, cost_employee: @payroll.cost_employee, payroll_employee: @payroll.payroll_employee } }, headers: @auth_tokens, as: :json
    end

    assert_response :created
  end

  test 'should show payroll' do
    get payroll_url(@payroll), headers: @auth_tokens, as: :json

    assert_response :success
  end

  test 'should update payroll' do
    patch payroll_url(@payroll),
          params: { payroll: { employee_id: @payroll.employee_id, end_date: @payroll.end_date, start_date: @payroll.start_date, cost_employee: @payroll.cost_employee, payroll_employee: @payroll.payroll_employee } }, headers: @auth_tokens, as: :json

    assert_response :success
  end

  test 'should destroy payroll' do
    assert_difference('Payroll.count', -1) do
      delete payroll_url(@payroll), headers: @auth_tokens, as: :json
    end

    assert_response :no_content
  end
end

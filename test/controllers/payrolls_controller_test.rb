# frozen_string_literal: true

require 'test_helper'

class PayrollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payroll = payrolls(:one)
  end

  test 'should get index' do
    get payrolls_url, as: :json
    assert_response :success
  end

  test 'should create payroll' do
    assert_difference('Payroll.count') do
      post payrolls_url,
           params: { payroll: { employee_id: @payroll.employee_id, end_date: @payroll.end_date, start_date: @payroll.start_date, total_deductions: @payroll.total_deductions, total_payroll: @payroll.total_payroll } }, as: :json
    end

    assert_response :created
  end

  test 'should show payroll' do
    get payroll_url(@payroll), as: :json
    assert_response :success
  end

  test 'should update payroll' do
    patch payroll_url(@payroll),
          params: { payroll: { employee_id: @payroll.employee_id, end_date: @payroll.end_date, start_date: @payroll.start_date, total_deductions: @payroll.total_deductions, total_payroll: @payroll.total_payroll } }, as: :json
    assert_response :success
  end

  test 'should destroy payroll' do
    assert_difference('Payroll.count', -1) do
      delete payroll_url(@payroll), as: :json
    end

    assert_response :no_content
  end
end

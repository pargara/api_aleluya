# frozen_string_literal: true

require 'test_helper'

class PayrollPeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payroll_period = payroll_periods(:one)
  end

  test 'should get index' do
    get payroll_periods_url, as: :json
    assert_response :success
  end

  test 'should create payroll_period' do
    assert_difference('PayrollPeriod.count') do
      post payroll_periods_url,
           params: { payroll_period: { company_id: @payroll_period.company_id, end_date: @payroll_period.end_date, percentage_of_pension_fund: @payroll_period.percentage_of_pension_fund, percentage_of_social_security: @payroll_period.percentage_of_social_security, start_date: @payroll_period.start_date } }, as: :json
    end

    assert_response :created
  end

  test 'should show payroll_period' do
    get payroll_period_url(@payroll_period), as: :json
    assert_response :success
  end

  test 'should update payroll_period' do
    patch payroll_period_url(@payroll_period),
          params: { payroll_period: { company_id: @payroll_period.company_id, end_date: @payroll_period.end_date, percentage_of_pension_fund: @payroll_period.percentage_of_pension_fund, percentage_of_social_security: @payroll_period.percentage_of_social_security, start_date: @payroll_period.start_date } }, as: :json
    assert_response :success
  end

  test 'should destroy payroll_period' do
    assert_difference('PayrollPeriod.count', -1) do
      delete payroll_period_url(@payroll_period), as: :json
    end

    assert_response :no_content
  end
end

# frozen_string_literal: true

require 'test_helper'
require_relative '../helpers/authorization_helper'

class PayrollPeriodsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @payroll_period = payroll_periods(:payroll_period_one)
    test_user = { email: 'user@test.com', password: 'testuser' }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test 'should get index' do
    get payroll_periods_url, headers: @auth_tokens, as: :json

    assert_response :success
  end

  test 'should create payroll_period' do
    assert_difference('PayrollPeriod.count') do
      # binding.break
      post payroll_periods_url,
           params: { payroll_period: { company_id: @payroll_period.company_id, start_date: @payroll_period.start_date, end_date: @payroll_period.end_date, percentage_of_pension_fund: @payroll_period.percentage_of_pension_fund, percentage_of_social_security: @payroll_period.percentage_of_social_security } }, headers: @auth_tokens, as: :json
    end

    assert_response :created
  end

  test 'should show payroll_period' do
    get payroll_period_url(@payroll_period), headers: @auth_tokens, as: :json

    assert_response :success
  end

  test 'should update payroll_period' do
    patch payroll_period_url(@payroll_period),
          params: { payroll_period: { company_id: @payroll_period.company_id, end_date: @payroll_period.end_date, percentage_of_pension_fund: @payroll_period.percentage_of_pension_fund, percentage_of_social_security: @payroll_period.percentage_of_social_security, start_date: @payroll_period.start_date } }, headers: @auth_tokens, as: :json
    assert_response :success
  end

  test 'should destroy payroll_period' do
    assert_difference('PayrollPeriod.count', -1) do
      delete payroll_period_url(@payroll_period), headers: @auth_tokens, as: :json
    end

    assert_response :no_content
  end
end

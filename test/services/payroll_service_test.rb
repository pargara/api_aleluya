# frozen_string_literal: true

require 'test_helper'
require 'payroll_service'

class PayrollServiceTest < ActiveSupport::TestCase
  def setup
    @payroll = payrolls(:payroll_one)
    @payroll_service = PayrollService.new(@payroll)
  end

  test 'the service should create a period' do
    assert_equal 30, @payroll_service.period.count, 'The period is correct'
  end

  test 'calculate base salary of the employee' do
    assert_equal 750000, @payroll_service.salary_employee,  'The salary of the employee is correct'
  end

  test 'calculate salary plus subsidy' do
    assert_equal 890000, @payroll_service.total_base_social_prestations, 'The base social prestations is correct'
  end

  test 'calculate total income' do
    assert_equal 890000, @payroll_service.total_income, 'The total income is correct'
  end

  test 'calculate employee obligations' do
    assert_equal 67500, @payroll_service.total_employee_retensions, 'The total employee retensions is correct'
  end

  test 'calculate company obligations' do
    assert_equal 157665, @payroll_service.total_company_retensions, 'The total company retensions is correct'
  end

  test 'calculate parafiscales' do
    assert_equal 30000, @payroll_service.total_parafiscales, 'The total of parafiscales is correct'
  end

  test 'calculate social benefits' do
    assert_equal 188484, @payroll_service.total_social_benefits.round, 'The total of social benefits is correct'
  end

  test 'calculate payroll employee' do
    assert_equal 822500, @payroll_service.payroll_employee, 'The payroll employee is correct'
  end

  test 'calculate cost employee' do
    assert_equal 1266149, @payroll_service.cost_employee, 'The cost employee is correct'
  end
end

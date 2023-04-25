# frozen_string_literal: true

require 'test_helper'

class PayrollPeriodTest < ActiveSupport::TestCase
  def setup
    @company = companies(:company_one)
    # @faild_payroll_period = payroll_periods(:payroll_period_two)
    @payroll_period = payroll_periods(:payroll_period_one)
  end

  test 'columns are valid is valid' do
    assert PayrollPeriod.column_names.include?('start_date'), 'column start_date is included in PayrollPeriod'
    assert_equal 'date', payroll_period_column_class('start_date').type.to_s, 'start_date column is a date'
    assert_not payroll_period_column_class('start_date').null, 'start_date column cant be null'

    assert PayrollPeriod.column_names.include?('end_date'), 'column end_date is included in PayrollPeriod'
    assert_equal 'date', payroll_period_column_class('end_date').type.to_s, 'end_date column is a date'
    assert_not payroll_period_column_class('end_date').null, 'end_date column cant be null'

    assert PayrollPeriod.column_names.include?('company_id'), 'column company_id is included in PayrollPeriod'
    assert_equal 'integer', payroll_period_column_class('company_id').type.to_s, 'company_id column is an integer'
    assert_not payroll_period_column_class('company_id').null, 'company_id column cant be null'

    assert PayrollPeriod.column_names.include?('percentage_of_social_security'),
           'column percentage_of_social_security is included in PayrollPeriod'
    assert_equal 'float', payroll_period_column_class('percentage_of_social_security').type.to_s,
                 'percentage_of_social_security column is a float'
    assert payroll_period_column_class('percentage_of_social_security').null,
           'percentage_of_social_security column can be null'

    assert PayrollPeriod.column_names.include?('percentage_of_pension_fund'),
           'column percentage_of_pension_fund is included in PayrollPeriod'
    assert_equal 'float', payroll_period_column_class('percentage_of_pension_fund').type.to_s,
                 'percentage_of_pension_fund column is a float'
    assert payroll_period_column_class('percentage_of_pension_fund').null,
           'percentage_of_pension_fund column can be null'

    assert PayrollPeriod.column_names.include?('compensation'), 'column compensation is included in PayrollPeriod'
    assert_equal 'float', payroll_period_column_class('compensation').type.to_s, 'compensation column is a float'
    assert payroll_period_column_class('compensation').null, 'compensation column can be null'

    assert PayrollPeriod.column_names.include?('icbf'), 'column icbf is included in PayrollPeriod'
    assert_equal 'float', payroll_period_column_class('icbf').type.to_s, 'icbf column is a float'
    assert payroll_period_column_class('icbf').null, 'icbf column can be null'

    assert PayrollPeriod.column_names.include?('sena'), 'Column sena is included in PayrollPeriod'
    assert_equal 'float', payroll_period_column_class('sena').type.to_s, 'sena column is a float'
    assert payroll_period_column_class('sena').null, 'sena column can be null'

    assert PayrollPeriod.column_names.include?('minimum_salary'), 'Column minimum_salary is included in PayrollPeriod'
    assert_equal 'integer', payroll_period_column_class('minimum_salary').type.to_s, 'minimum_salary column is a float'
    assert payroll_period_column_class('minimum_salary').null, 'minimum_salary column can be null'

    assert PayrollPeriod.column_names.include?('transport_subsidy'),
           'Column transport_subsidy is included in PayrollPeriod'
    assert_equal 'integer', payroll_period_column_class('transport_subsidy').type.to_s,
                 'transport_subsidy column is a float'
    assert payroll_period_column_class('transport_subsidy').null, 'transport_subsidy column can be null'
  end

  test 'payroll_period have a relationship with a company' do
    assert_equal companies(:company_one), @payroll_period.company
  end

  test 'payroll_period is created with valid params' do
    assert @payroll_period.save, 'Payroll period was saved'
  end

  test 'payroll_period is not created with nill params' do
    @payroll_period.company_id = nil
    assert_not @payroll_period.save, 'Payroll period cant be saved with nill params'
  end

  test 'payroll_period cant be created with unsafe params' do
    payroll_period = PayrollPeriod.new(company_id: '**@@', start_date: '++@', end_date: '++@')
    assert_not payroll_period.save, 'Payroll period cant be saved with unsafe params'
  end

  def payroll_period_column_class(column_name)
    PayrollPeriod.columns.detect { |c| c.name == column_name.to_s }
  end
end

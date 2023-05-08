# frozen_string_literal: true

require 'test_helper'

class PayrollTest < ActiveSupport::TestCase
  def setup
    @payroll = payrolls(:payroll_one)
    @employee = employees(:employee_one)
  end

  test 'colums valid is valid' do
    assert Payroll.column_names.include?('cost_employee'), 'column cost_employee is included in Payroll'
    assert_equal 'integer', payroll_column_class('cost_employee').type.to_s, 'cost_employee column is a float'
    assert payroll_column_class('cost_employee').null, 'cost_employee column can be null'

    assert Payroll.column_names.include?('payroll_employee'), 'column payroll_employee is included in Payroll'
    assert_equal 'integer', payroll_column_class('payroll_employee').type.to_s, 'payroll_employee column is a float'
    assert payroll_column_class('payroll_employee').null, 'payroll_employee column can be null'

    assert Payroll.column_names.include?('start_date'), 'column start_date is included in Payroll'
    assert_equal 'date', payroll_column_class('start_date').type.to_s, 'start_date column is a date'
    assert_not payroll_column_class('start_date').null, 'start_date column cannot be null'

    assert Payroll.column_names.include?('end_date'), 'column end_date is included in Payroll'
    assert_equal 'date', payroll_column_class('end_date').type.to_s, 'end_date column is a date'
    assert_not payroll_column_class('end_date').null, 'end_date column cannot be null'
  end

  test 'payroll has a relationship with payroll_period' do
    assert_equal @employee, @payroll.employee, 'payroll has a relationship with payroll_period'
  end

  test 'payroll is created correctly' do
    assert @payroll.valid?, 'payroll is created correctly'
  end

  test 'payroll cant be created with nill params' do
    payroll = Payroll.new
    assert_not payroll.save, 'payroll cant be created with nill params'
  end

  test 'payroll cant be created with unsafe params' do
    payroll = Payroll.new(cost_employee: '*@@@@', payroll_employee: '++@@', start_date: '++@@', end_date: '@@++')
    assert_not payroll.save, 'payroll cant be created with unsafe params'
  end

  def payroll_column_class(_column_name)
    Payroll.columns.detect { |c| c.name == column.to_s }
  end
end

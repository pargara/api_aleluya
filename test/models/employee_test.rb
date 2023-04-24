# frozen_string_literal: true

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  def setup
    @employee = employees(:employee_one)
    @payroll_period = payroll_periods(:payroll_period_one)
  end

  test 'colums valid is valid' do
    assert Employee.column_names.include?('base_salary'), 'column base_salary is included in Employee'
    assert_equal 'integer', employee_column_class('base_salary').type.to_s, 'base_salary column is a float'
    assert_not employee_column_class('base_salary').null, 'name column is not null'

    assert Employee.column_names.include?('name'), 'column name is included in Employee'
    assert_equal 'string', employee_column_class('name').type.to_s, 'name column is a string'
    assert_not employee_column_class('name').null, 'name column is not null'

    assert Employee.column_names.include?('document_identity'), 'column document_identity is included in Employee'
    assert_equal 'integer', employee_column_class('document_identity').type.to_s, 'document_identity column is a string'
    assert_not employee_column_class('document_identity').null, 'document_identity column cant be null'

    assert Employee.column_names.include?('payroll_period_id'), 'column payroll_period_id is included in Employee'
    assert_equal 'integer', employee_column_class('payroll_period_id').type.to_s,
                 'payroll_period_id column is an integer'
    assert_not employee_column_class('payroll_period_id').null, 'payroll_period_id column cant be null'

    assert Employee.column_names.include?('percentage_of_social_security'),
           'column percentage_of_social_security is included in Employee'
    assert_equal 'float', employee_column_class('percentage_of_social_security').type.to_s,
                 'percentage_of_social_security column is a float'
    assert employee_column_class('percentage_of_social_security').null,
           'percentage_of_social_security column can be null'

    assert Employee.column_names.include?('percentage_of_pension_fund'),
           'column percentage_of_pension_fund is included in Employee'
    assert_equal 'float', employee_column_class('percentage_of_pension_fund').type.to_s,
                 'percentage_of_pension_fund column is a float'
    assert employee_column_class('percentage_of_pension_fund').null, 'percentage_of_pension_fund column can be null'

    assert Employee.column_names.include?('solidarity_fund'), 'column solidarity_fund is included in Employee'
    assert_equal 'float', employee_column_class('solidarity_fund').type.to_s, 'solidarity_fund column is a float'
    assert employee_column_class('solidarity_fund').null, 'solidarity_fund column can be null'

    assert Employee.column_names.include?('subsistence_fund'), 'column subsistance_fund is included in Employee'
    assert_equal 'float', employee_column_class('subsistence_fund').type.to_s, 'subsistance_fund column is a float'
    assert employee_column_class('subsistence_fund').null, 'subsistance_fund column can be null'

    assert Employee.column_names.include?('total_deductions'), 'column total_deductions is included in Employee'
    assert_equal 'integer', employee_column_class('total_deductions').type.to_s, 'total_deductions column is a float'
    assert employee_column_class('total_deductions').null, 'total_deductions column can be null'

    assert Employee.column_names.include?('non_salary_income'), 'column non_salary_income is included in Employee'
    assert_equal 'integer', employee_column_class('non_salary_income').type.to_s, 'non_salary_income column is a float'
    assert employee_column_class('non_salary_income').null, 'non_salary_income column can be null'

    assert Employee.column_names.include?('other_salary_income'), 'column other_salary_income is included in Employee'
    assert_equal 'integer', employee_column_class('other_salary_income').type.to_s,
                 'other_salary_income column is a float'
    assert employee_column_class('other_salary_income').null, 'other_salary_income column can be null'
  end

  test 'employee has a relationship with payroll_period' do
    assert_equal @employee.payroll_period, @payroll_period, 'employee has a relationship with payroll_period'
  end

  test 'employee is created correctly' do
    assert @employee.valid?, 'employee is valid'
  end

  test 'employee cant be created with nill params' do
    employee = Employee.new
    assert_not employee.save, 'employee is not valid'
  end

  test 'employee cant be created with unsafe params' do
    employee = Employee.new(name: '@@++', document_identity: '@@++', payroll_period_id: '++@@', base_salary: '@@**')
    assert_not employee.save, 'employee is not valid'
  end

  def employee_column_class(column)
    Employee.columns.detect { |c| c.name == column.to_s }
  end
end

# frozen_string_literal: true

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @company = companies(:company_one)
    @faild_company = companies(:company_two)
    @user_one = users(:user_one)
  end

  test 'columns are valid is valid' do
    assert Company.column_names.include?('name'), 'column name is included in Company'
    assert_equal 'string', company_column_class('name').type.to_s, 'name column is a string'
    assert_not company_column_class('name').null, 'name column is not null'

    assert Company.column_names.include?('phone'), 'column phone is included in Company'
    assert_equal 'string', company_column_class('phone').type.to_s, 'phone column is a string'
    assert company_column_class('phone').null, 'phone column can be null'

    assert Company.column_names.include?('direction'), 'column direction is included in Company'
    assert_equal 'string', company_column_class('direction').type.to_s, 'direction column is a string'
    assert company_column_class('direction').null, 'direction column can be null'

    assert Company.column_names.include?('mail'), 'column mail is included in Company'
    assert_equal 'string', company_column_class('mail').type.to_s, 'mail column is a string'
    assert_not company_column_class('mail').null, 'mail column is not null'
  end

  test 'company have a relationship with user' do
    assert_equal @company.user, @user_one, 'company have a relationship with user'
  end

  test 'Company cant be created with unsafe params' do
    company = Company.new(name: '@@+', mail: '@@@~', phone: '~@@', direction: '@@@~~')
    assert_not company.save, 'Company cant be created with unsafe params'
  end

  test 'Company cant be created with nil params' do
    assert_not @faild_company.save, 'Company cant be created with nill params'
  end

  test 'Company is created with valid params' do
    assert @company.save, 'Company is created with valid params'
  end

  def company_column_class(column)
    Company.columns.detect { |c| c.name == column.to_s }
  end
end

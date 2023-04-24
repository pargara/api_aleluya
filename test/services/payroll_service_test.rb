# frozen_string_literal: true

require 'test_helper'
require 'payroll_service'

class PayrollServiceTest < ActiveSupport::TestCase
  def setup
    @payroll = payrolls(:payroll_one)
    @payroll_service = PayrollService.new(@payroll)
  end

  test 'the service should create a period' do
    assert @payroll_service.period.count, 30
  end
end

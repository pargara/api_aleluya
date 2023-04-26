# frozen_string_literal: true

class PayrollPeriodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payroll_period, only: %i[show update destroy]

  # GET /payroll_periods
  def index
    @companies = current_user.companies
    @payroll_periods = PayrollPeriod.all
  end

  # GET /payroll_periods/1
  def show
    render json: @payroll_period
  end

  # POST /payroll_periods
  def create
    @payroll_period = PayrollPeriod.new(payroll_period_params)

    if @payroll_period.save
      # render json: @payroll_period, status: :created, location: @payroll_period
      render :create, status: :created, location: @payroll_period
    else
      # render json: @payroll_period.errors, status: :unprocessable_entity
      render 'errors/errors', locals: { object: @payroll_period }, formats: :json, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payroll_periods/1
  def update
    if @payroll_period.update(payroll_period_params)
      render json: @payroll_period
    else
      # render json: @payroll_period.errors, status: :unprocessable_entity
      render 'errors/errors', locals: { object: @payroll_period }, formats: :json, status: :unprocessable_entity
    end
  end

  # DELETE /payroll_periods/1
  def destroy
    @payroll_period.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payroll_period
    @payroll_period = PayrollPeriod.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payroll_period_params
    params.require(:payroll_period).permit(:company_id, :percentage_of_social_security, :percentage_of_pension_fund,
                                           :start_date, :end_date, :minimum_salary, :transport_subsidy)
  end
end

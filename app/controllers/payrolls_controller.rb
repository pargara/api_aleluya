# frozen_string_literal: true

class PayrollsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payroll, only: %i[show update destroy]

  # GET /payrolls
  def index
    # @payrolls = Payroll.all
    @payrolls = Payroll.joins(employee: {payroll_period: :company}).where(companies: {user_id: current_user.id})
    # render json: @payrolls
  end

  # GET /payrolls/1
  def show
    render json: @payroll
  end

  # POST /payrolls
  def create
    @payroll = Payroll.new(payroll_params)
    if @payroll.save

      render :create, status: :created, location: @payroll
    else
      # render json: @payroll.errors, status: :unprocessable_entity
      render 'errors/errors', locals: { object: @payroll }, formats: :json, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payrolls/1
  def update
    if @payroll.update(payroll_params)
      render json: @payroll
    else
      # render json: @payroll.errors, status: :unprocessable_entity
      render 'errors/errors', locals: { object: @payroll }, formats: :json, status: :unprocessable_entity
    end
  end

  # DELETE /payrolls/1
  def destroy
    @payroll.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payroll
    @payroll = Payroll.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payroll_params
    params.require(:payroll).permit(:employee_id, :cost_employee, :payroll_employee, :start_date, :end_date)
  end
end

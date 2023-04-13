class PayrollsController < ApplicationController
  before_action :set_payroll, only: %i[ show update destroy ]

  # GET /payrolls
  def index
    @payrolls = Payroll.all

    render json: @payrolls
  end

  # GET /payrolls/1
  def show
    render json: @payroll
  end

  # POST /payrolls
  def create
    @payroll = Payroll.new(payroll_params)

    if @payroll.save
      render json: @payroll, status: :created, location: @payroll
    else
      render json: @payroll.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payrolls/1
  def update
    if @payroll.update(payroll_params)
      render json: @payroll
    else
      render json: @payroll.errors, status: :unprocessable_entity
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
      params.require(:payroll).permit(:employee_id, :total_deductions, :total_payroll, :start_date, :end_date)
    end
end

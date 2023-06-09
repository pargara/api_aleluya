# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: %i[show update destroy]

  # GET /employees
  def index
    @companies = current_user.companies
    @employees = Employee.all
  end

  # GET /employees/1
  def show
    render json: @employee
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render :create, status: :created, location: @employee
    else
      render 'errors/errors', locals: { object: @employee }, formats: :json, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render 'errors/errors', locals: { object: @employee }, formats: :json, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:payroll_period_id, :base_salary, :percentage_of_social_security,
                                     :percentage_of_pension_fund, :total_deductions, :non_salary_income, :other_dedections, :name, :document_identity)
  end
end

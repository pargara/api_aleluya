class PayrollService
  attr_accessor :period, :salary_employee, :base_ss_parafiscales, :total_base_social_prestations, :total_income, :total_employee_retensions, :total_company_retensions, :total_parafiscales, :total_social_benefits, :payroll_employee, :cost_employee

  def initialize(data)
    @data = data

    calculate_period
    set_data
  end

  def calculate_period
    @period = @data.start_date..@data.end_date

    calculate_salary
  end
  
  def calculate_salary
    @salary_employee = (@data.employee.base_salary * @period.count) / 30
    calculate_base_ss_parafiscales
  end

  def calculate_base_ss_parafiscales
    @base_ss_parafiscales = @salary_employee

    if !@data.employee.other_salary_income.nil?
     @base_ss_parafiscales += @data.employee.other_salary_income
    end

    calculate_salary_plus_subsidy
  end

  def calculate_salary_plus_subsidy
    if @salary_employee < 2500000
      @total_base_social_prestations = @base_ss_parafiscales + @data.employee.payroll_period.transport_subsidy
    else
      @total_base_social_prestations = @base_ss_parafiscales
    end

    calculate_total_income
  end
    
  def calculate_total_income
    @total_income = @total_base_social_prestations 
    if !@data.employee.non_salary_income.nil?
      @total_income += @data.employee.non_salary_income
    end

    calculate_employee_retensions
  end

  def calculate_employee_retensions
    @total_health = (@base_ss_parafiscales * @data.employee.percentage_of_social_security) / 100
    @total_pension_fund = (@base_ss_parafiscales * @data.employee.percentage_of_pension_fund) / 100
    @total_subsistence_fund = (@base_ss_parafiscales * @data.employee.subsistence_fund) / 100
    @total_solidarity_fund = (@base_ss_parafiscales * @data.employee.solidarity_fund) / 100


    @total_employee_retensions = @total_health + @total_pension_fund + @total_subsistence_fund + @total_solidarity_fund

    if !@data.employee.total_deductions.nil?
      @total_employee_retensions += @data.employee.total_deductions
    end

    calculate_company_obligations
  end

  def calculate_company_obligations
    @total_company_health = (@base_ss_parafiscales * @data.employee.payroll_period.percentage_of_social_security) / 100
    @total_company_pension_fund = (@base_ss_parafiscales * @data.employee.payroll_period.percentage_of_pension_fund) / 100
    @total_arl = (@base_ss_parafiscales * @data.employee.percentage_arl) / 100

    @total_company_retensions = @total_company_health + @total_company_pension_fund + @total_arl

    calculate_parafiscales
  end

  def calculate_parafiscales
    @total_box_compensation = (@base_ss_parafiscales * 4) / 100
    @total_parafiscales = @total_box_compensation

    if @salary_employee > 10000000
      @total_icbf = (@base_ss_parafiscales * 3) / 100
      @total_sena = (@base_ss_parafiscales * 2) / 100

      @total_parafiscales += @total_icbf + @total_sena
    end

    calculate_social_benefits
  end

  def calculate_social_benefits
    @prima_de_servicios = 1/12.0
    @vacations = 1/24.0
    @interest_on_cesantias = 0.12

    @total_cesantias = @prima_de_servicios * @total_base_social_prestations
    @total_prima_de_servicios = @total_cesantias
    @total_interest_on_cesantias = @total_cesantias * @interest_on_cesantias
    @total_vacations = @base_ss_parafiscales * @vacations

    @total_social_benefits = @total_cesantias.round + @total_vacations.round + @total_prima_de_servicios + @total_interest_on_cesantias.round

    calculate_total_payroll
  end

  def calculate_total_payroll
    @payroll_employee = @total_income - @total_employee_retensions

    calculate_employee_cost
  end

  def calculate_employee_cost
    @cost_employee = @total_income + @total_company_retensions + @total_social_benefits.round + @total_parafiscales
  end

  def set_data
    @data.cost_employee = @cost_employee.round
    @data.payroll_employee = @payroll_employee.round
  end
end

class PayrollService
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

    calculate_salary_plus_subsidy
  end

  def calculate_salary_plus_subsidy
    if @salary_employee < 2500000
      @total_base_social_prestations = @salary_employee + @data.employee.payroll_period.transport_subsidy
    end

    calculate_total_income
  end
    
  def calculate_total_income
    # Por hacer: un setter a 0 para employee.non_salary_income para que no sea nill si no que sea 0
    @total_income = @total_base_social_prestations 
    if !@data.employee.non_salary_income.nil?
      @total_income += @data.employee.non_salary_income
    end

    calculate_base_ss_parafiscales
  end

  def calculate_base_ss_parafiscales
    @base_ss_parafiscales = @salary_employee
    if !@data.employee.other_salary_income.nil?
     @base_ss_parafiscales += @data.employee.other_salary_income
    end

    calculate_employee_retensions
  end

  def calculate_employee_retensions
    @total_health = (@base_ss_parafiscales * @data.employee.percentage_of_social_security) / 100
    @total_pension_fund = (@base_ss_parafiscales * @data.employee.percentage_of_pension_fund) / 100
    @total_subsistence_fund = (@base_ss_parafiscales * @data.employee.subsistence_fund) / 100
    @total_solidarity_fund = (@base_ss_parafiscales * @data.employee.solidarity_fund) / 100

    @total_employee_retensions = @total_health + @total_pension_fund + @total_solidarity_fund + @total_subsistence_fund

    calculate_company_obligations
  end

  def calculate_company_obligations
    @total_company_health = (@base_ss_parafiscales * @data.employee.payroll_period.percentage_of_social_security) / 100
    @total_company_pension_fund = (@base_ss_parafiscales * @data.employee.payroll_period.percentage_of_pension_fund) / 100
    @tota_arl = (@base_ss_parafiscales * @data.employee.payroll_period.percentage_arl) / 100

    @total_company_retensions = @total_company_health + @total_company_pension_fund

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
    @total_cesantias = @prima_de_servicios.round * @total_base_social_prestations
    @total_prima_de_servicios = @total_cesantias
    @vacations = 1/24.0
    @total_vacations = @base_ss_parafiscales * @vacations.round

    @total_social_benefits = @total_cesantias + @total_vacations + @total_prima_de_servicios

    calculate_total_payroll
  end

  def calculate_total_payroll
    @payroll_employee = @total_income - @total_employee_retensions
    calculate_employee_cost
  end

  def calculate_employee_cost
    @cost_employee = @total_income + @total_company_retensions + @total_social_benefits + @total_parafiscales
  end

  def set_data
    @data.cost_employee = @cost_employee.round
    @data.payroll_employee = @payroll_employee.round
  end
end

class PayrollService
  def initialize
    calculate_salary_plus_subsidy
  end

  def calculate_period
    @period = self.start_date..self.end_date
  end
  
  def calculate_salary
    @salary_employee = self.employee.base_salary / @period.size
  end

  def calculate_salary_plus_subsidy
    # Como?
    # tengo que subir hasta el empledo si su salario es menor a
    # 2.5M sumo subsidio de transporte de alli resto Retenciones
    if @salary_employee > 2500000
      @total_base_social_prestacions = @salary_employee + self.payroll_period.transport_subsidy
    end
  end
    
  def calculate_total_income
    @total_income = @total_base_social_prestations * self.employee.non_salary_income
  end

  def calculate_base_ss_parafiscales
    @base_ss_parafiscales = @salary_employee * self.employee.other_salary_income
  end

  def calculate_employee_retensions
    @total_social_security = (@salary_employee * self.employee.percentage_of_social_security) / 100
    @total_pension_fund = (@salary_employee * self.employee.percentage_of_pension_fund) / 100
    @total_employee_retensions = @total_social_security + @total_pension_fund
    @net_salary = @net_salary - @total_employee_retensions
  end

  def calculate_company_obligations
    @total_company_social_security = (@salary_employee * self.payroll_periods.percentage_of_social_security) / 100
    @total_company_pension_fund = (@salary_employee * self.payroll_periods.percentage_of_pension_fund) / 100

    @total_employee_retensions = @total_company_social_security + @total_company_pension_fund
  end

  def calculate_parafiscales
    # falta si la persona gana 10M o mas se le cobran desde el 70% de su salario el 3% del ICBF y del SENA un 2%
    if @salary_employee > 10000000
      @total_icbf = (@salary_employee * 3) / 100
      @total_sena = (@salary_employee * 2) / 100

      @total_parafiscales = @total_icbf + @total_sena
    end
  end

  def calculate_social_benefits
    # Falta hacer cargar campos al modelo, hacer refactor y dar un solo total
    @prima_de_servicios = 8.33
    @tota_cesantias = @net_salary * @prima_de_servicios
    @total_prima_de_servicios = @total_cesantias
    @vacations = 4.17
    @total_vacations = @salaly_employee * @vacations
  end

  def calculate_total_payroll
    @payroll_employee = 
  end
end

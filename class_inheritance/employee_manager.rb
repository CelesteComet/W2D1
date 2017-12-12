class Employee
  attr_reader :salary
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

end

class Manager < Employee
  attr_accessor :employees
  def initialize(name, title, salary, boss)
    @employees = []
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    self.get_employees_total_salaries * multiplier
  end

  def get_employees_total_salaries
    sum = 0
    @employees.each do |employee|
      if employee.is_a?(Manager)
        sum += employee.salary + employee.get_employees_total_salaries
      else
        sum += employee.salary
      end
    end
    sum
  end
end

ned = Manager.new("Ned","Founder", 1_000_000, nil)
darren = Manager.new("Darren","TA Manager",78_000,ned)
ned.employees << darren
shawna = Employee.new("Shawna","TA",12_000,darren)
david = Employee.new("david","TA",10_000,darren)
darren.employees << david
darren.employees << shawna

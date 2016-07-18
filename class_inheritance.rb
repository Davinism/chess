class Employee
  attr_reader :name, :title, :salary, :boss

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
  def initialize(name, title, salary, boss, employees)
    @employees = employees
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    sum = 0
    @employees.each do |employee|
      sum += employee.salary
    end
    sum * multiplier
  end
end

darren, ned = nil, nil
shawna = Employee.new("Shawna", "TA", 12000, darren)
david = Employee.new("David", "TA", 10000, darren)
employees1 = [shawna, david]
darren = Manager.new("Darren", "TA Manager", 78000, ned, employees1)
employees2 = [darren, shawna, david]
ned = Manager.new("Ned", "Founder", 1000000, nil, employees2)

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000
p david.boss

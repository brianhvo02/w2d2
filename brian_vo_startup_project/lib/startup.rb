require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries

        @employees = []
    end

    def valid_title?(title)
        @salaries.keys.include?(title)
    end

    def >(startup)
        @funding > startup.funding
    end

    def hire(name, title)
        raise ArgumentError.new("invalid title") if !valid_title?(title)

        @employees << Employee.new(name, title)
    end

    def size
        @employees.length
    end

    def pay_employee(emp)
        sal = @salaries[emp.title]

        if (@funding >= sal)
            emp.pay(sal)
            @funding -= sal
        else
            raise RuntimeError.new("not enough funding to pay employee")
        end
    end

    def payday
        @employees.each { |e| pay_employee(e) }
    end

    def average_salary
        @employees.inject(0) { |acc, ele| acc + @salaries[ele.title] } / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding = @funding += startup.funding
        @salaries = startup.salaries.merge(@salaries)
        @employees.concat(startup.employees)
        startup.close
    end
end

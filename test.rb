require_relative 'app/models/meal'
require_relative 'app/repositories/meal_repository'
require_relative 'app/repositories/employee_repository'
require_relative 'app/models/employee'

# meal_repository = MealRepository.new('data/meals.csv')
# p meal_repository

# meal_one = Meal.new({ name: 'Pizza', price: 7 })
# p meal_one


# require_relative 'app/models/customer'
# customer_one = Customer.new({ name: 'John', address: 'Ipanema' })
# p customer_one


employee_manager = Employee.new(username: 'manager', password: 'secret', role: 'rider')
p employee_manager.manager?

employee_repo = EmployeeRepository.new('data/employees.csv')
p employee_repo

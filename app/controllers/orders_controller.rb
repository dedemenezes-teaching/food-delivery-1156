require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/employee_view'
require_relative '../views/order_view'
require 'pry-byebug'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @employee_view = EmployeeView.new
    @order_view = OrderView.new
  end

  def add
    meal = set_meal
    customer = set_customer
    rider = set_rider
    # 4. instantiate the new order
    new_order = Order.new(meal: meal, customer: customer, employee: rider)
    # 5. Ask the repo to store it
    @order_repository.create(new_order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    # binding.pry
    @order_view.display(orders)
  end

  def list_my_orders(current_user)
    # we need to know who is logged in!
    # THAT WHY WE HAVE THE PARAMETER!
    my_undelivered_orders = @order_repository.my_undelivered_orders(current_user)
    @order_view.display(my_undelivered_orders)
  end

  def mark_as_delivered(current_user)
    # 1. list all my undelivered orders
    my_undelivered_orders = @order_repository.my_undelivered_orders(current_user)
    @order_view.display(my_undelivered_orders)
    # 2. ask which one to mark as delivered
    index = @order_view.ask_for_index
    order = my_undelivered_orders[index]
    @order_repository.mark_as_delivered(order)
  end

  def set_rider
    # 3. instance of employee(only rider)
    riders = @employee_repository.all_riders
    @employee_view.display(riders)
    index = @order_view.ask_for_index
    riders[index]
  end

  def set_meal
    # 1. instance of meal
    # 1.1 List all meals
    meals = @meal_repository.all
    @meal_view.display(meals)
    # retrieve the right meal instance from the meals array
    # 1.2 choose the right meal
    index = @order_view.ask_for_index
    meals[index]
  end

  def set_customer
    # 2. instance of customer
    customers = @customer_repository.all
    @customer_view.display(customers)
    index = @order_view.ask_for_index
    customer = customers[index]
  end
end

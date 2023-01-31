require_relative '../views/customer_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomerView.new
  end

  def list
    # 1. retrieve all the customers (customer repository)
    customers = @customer_repository.all
    # 2. Display all the customers to the user (View)
    @view.display(customers)
  end

  def add
    # 1. Ask for the meal name (View)
    customer_name = @view.ask_for_name
    # 2. Ask for the customer address (View)
    customer_address = @view.ask_for_address
    # 3. instantiate the new customer #.new
    new_customer = Customer.new({name: customer_name, address: customer_address})
    # 4. Ask the repository to store this new customer
    @customer_repository.create(new_customer)
  end
end

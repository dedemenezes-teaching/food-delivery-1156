# TODO: implement the router of your app.
class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @orders_controller = orders_controller
    @sessions_controller  = sessions_controller
    @meals_controller     = meals_controller
    @customers_controller = customers_controller
    @running              = true
  end

  def run
    while @running
      @employee = @sessions_controller.login
      while @employee # make it nil
        if @employee.manager?
          # 1. Display the user actions [list meal | add meal |...]
          display_manager_menu
          # 2. Get the user action to execute
          action = gets.chomp.to_i
          # 3. Call the right controller method/action
          route_manager(action)
        else
          # 1. Display the user actions [list meal | add meal |...]
          display_rider_menu
          # 2. Get the user action to execute
          action = gets.chomp.to_i
          # 3. Call the right controller method/action
          route_rider(action)
        end
      end
    end
  end

  def display_rider_menu
    puts "1. List my undelivered orders"
    puts "2. Mark as delivered"
    puts '9. Quit'
  end

  def route_rider(action)
    case action
    when 1
      @orders_controller.list_my_orders(@employee)
    when 2
      @orders_controller.mark_as_delivered(@employee)
    when 9
      puts 'Good bye zo/'
      @employee = nil
      @running = false
    else
      puts 'Wrong action..'
    end
  end

  def display_manager_menu
    puts "1. List all the meals"
    puts "2. Add a new meal"
    puts "3. List all the customers"
    puts "4. Add a new customer"
    puts "5. Add a new order"
    puts '6. List undelivered orders'
    puts "8. Logout"
    puts '9. Quit'
  end

  def route_manager(user_choice)
    case user_choice
    when 1
      # We want to call the method list from the meals controller
      @meals_controller.list
    when 2
      @meals_controller.add
    when 3
      @customers_controller.list
    when 4
      @customers_controller.add
    when 5
      @orders_controller.add
    when 6
      @orders_controller.list_undelivered_orders
    when 8
      @employee = nil
    when 9
      puts 'Good bye zo/'
      @employee = nil
      @running = false
    else
      puts "Wrong action..."
    end
  end
end

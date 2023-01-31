# TODO: implement the router of your app.
class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller     = meals_controller
    @customers_controller = customers_controller
    @running              = true
  end

  def run
    while @running
      # 1. Display the user actions [list meal | add meal |...]
      puts "1. List all the meals"
      puts "2. Add a new meal"
      puts "3. List all the customers"
      puts "4. Add a new customer"
      puts '5. Quit'
      # 2. Get the user action to execute
      action = gets.chomp.to_i
      # 3. Call the right controller method/action
      case action
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
        puts 'Good bye zo/'
        @running = false
      else
        puts "Wrong action..."
      end
    end
  end
end

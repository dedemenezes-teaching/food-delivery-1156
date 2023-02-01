class OrderView
  def ask_for_index
    puts "Index?"
    gets.chomp.to_i - 1
  end

  def display(orders)
    orders.each_with_index do |order, index|
      status = order.delivered? ? '[X]' : '[ ]'

      puts "#{index + 1} - #{status} - Meal: #{order.meal.name}, Customer: #{order.customer.name}, Rider: #{order.employee.username}"
    end
  end
end

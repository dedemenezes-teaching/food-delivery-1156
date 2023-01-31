class CustomerView
  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} || #{customer.address}"
    end
  end

  def ask_for_name
    puts "Name?"
    return gets.chomp
  end

  def ask_for_address
    puts "Address?"
    return gets.chomp
  end
end

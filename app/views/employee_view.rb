class EmployeeView
  # NO INITIALIZE
  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def ask_for(item)
    puts "#{item}?"
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong credentials...Try again!"
  end
end

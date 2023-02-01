class EmployeeView
  # NO INITIALIZE
  def ask_for(item)
    puts "#{item}?"
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong credentials...Try again!"
  end
end

class MealView
  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} || $#{meal.price}"
    end
  end

  def ask_for_name
    puts "Name?"
    return gets.chomp
  end

  def ask_for_price
    puts "Price?"
    return gets.chomp.to_i
  end
end

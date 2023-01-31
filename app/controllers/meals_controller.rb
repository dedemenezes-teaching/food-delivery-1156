require_relative '../views/meal_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealView.new
  end

  def list
    # 1. retrieve all the meals (meal repository)
    meals = @meal_repository.all
    # 2. Display all the meals to the user (View)
    @view.display(meals)
  end

  def add
    # 1. Ask for the meal name (View)
    meal_name = @view.ask_for_name
    # 2. Ask for the meal price (View)
    meal_price = @view.ask_for_price
    # 3. instantiate the new Meal #.new
    new_meal = Meal.new({name: meal_name, price: meal_price})
    # 4. Ask the repository to store this new meal
    @meal_repository.create(new_meal)
  end
end

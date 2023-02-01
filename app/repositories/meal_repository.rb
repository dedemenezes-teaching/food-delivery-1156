require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    load_csv if File.exist?(csv_file_path)
  end

  def all
    @meals
  end

  def create(meal)
    # 1. SET THE MEAL ID
    id = @meals.empty? ? 1 : @meals.last.id + 1
    meal.id = id
    # 2. POPULATE MEAL ARRAY
    @meals << meal
    # 3. SAVE INTO CSV
    save_csv
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # 1. push headers into CSV
      csv << ['id', 'name', 'price']
      # 2. push ALL meals into csv
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # p row
      #<CSV::Row id:"1" name:"pizza" price:"7">
      # 1. Convert to thre right data type
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      # 2. Instantiate a new Meal
      new_meal = Meal.new(row)
      # 3. Populate meals array
      @meals << new_meal
    end
  end
end

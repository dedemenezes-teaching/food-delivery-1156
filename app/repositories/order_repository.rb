require_relative '../models/order'
require 'csv'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @csv_file_path = csv_file_path
    @orders = []
    load_csv
  end

  def create(order)
    # 1. SET THE order ID
    new_order_id = @orders.empty? ? 1 : @orders.last.id + 1
    order.id = new_order_id
    # 2. POPULATE order ARRAY
    @orders << order
    # 3. SAVE INTO CSV
    save_csv
  end

  def undelivered_orders
    # an array with instances of Order class undelivered
    # binding.pry
    @orders.reject { |order| order.delivered? }
  end

  def my_undelivered_orders(current_user)
    all_undelivered = undelivered_orders
    my_undelivered_orders = all_undelivered.select { |order| order.employee == current_user }
  end

  def mark_as_delivered(order)
    # 3. Mark it as delivered
    order.delivered!
    # 4. save this order delivered
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << [:id, :delivered, :meal_id, :customer_id, :employee_id]
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # 1. Convert all values to the right data type
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      # 2. Instantiate the new Order
      order = Order.new(row)
      # 3. Populate the orders array
      @orders << order
    end
  end
end

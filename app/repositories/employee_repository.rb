require_relative '../models/employee'
require 'csv'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(csv_file_path)
  end

  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # p row
      # 1. Convert to thre right data type
      row[:id] = row[:id].to_i
      # 2. Instantiate a new Customer
      new_employee = Employee.new(row)
      # 3. Populate meals array
      @employees << new_employee
    end
  end
end

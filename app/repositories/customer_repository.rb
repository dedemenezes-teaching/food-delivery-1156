require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    load_csv if File.exist?(csv_file_path)
  end

  def all
    @customers
  end

  def create(customer)
    # 1. SET THE customer ID
    id = @customers.empty? ? 1 : @customers.last.id + 1
    customer.id = id
    # 2. POPULATE customer ARRAY
    @customers << customer
    # 3. SAVE INTO CSV
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # 1. push headers into CSV
      csv << ['id', 'name', 'address']
      # 2. push ALL meals into csv
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # p row
      #<CSV::Row id:"1" name:"John" address:"Ipanema">
      # 1. Convert to thre right data type
      row[:id] = row[:id].to_i
      # 2. Instantiate a new Customer
      new_customer = Customer.new(row)
      # 3. Populate meals array
      @customers << new_customer
    end
  end
end

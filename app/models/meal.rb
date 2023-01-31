class Meal
  attr_reader :name, :price
  attr_accessor :id
  # STATE
  # id    #=> Integer
  # name  #=> String
  # price #=> Integer
  def initialize(attributes = {})
    @name = attributes[:name]
    @price = attributes[:price]
    @id = attributes[:id]
  end


  # def name
  #   @name
  # end
end

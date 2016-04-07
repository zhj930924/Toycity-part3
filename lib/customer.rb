class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    add_to_customers
  end

  def self.all
    @@customers
  end

  def self.find_by_name(name)
    @@customers.find { |customer| customer.name == name }
  end

  def purchase(product)
    if product.in_stock?
      Transaction.new(self, product)
    else
      raise OutOfStockError, "'#{product.title}' is out of stock."
    end
  end

  def return(product)
    Transaction.new(self, product, type: 'return')
  end

  private

  def add_to_customers
    if @@customers.any? { |customer| customer.name == @name }
      raise DuplicateCustomerError, "'#{@name}' already exists."
    else
      @@customers << self
    end
  end
end

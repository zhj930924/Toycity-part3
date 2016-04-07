class Transaction
  attr_reader :id, :customer, :product

  @@transactions = []
  @@id = 1

  def initialize(customer, product)
    @customer = customer
    @product = product
    add_to_transactions
    @id = @@id
    @@id += 1
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions.each do |transaction|
      return transaction if transaction.id == id
    end
  end

  private

  def add_to_transactions
    if @product.in_stock?
      @product.reduce_stock
      @@transactions << self
    else
      raise OutOfStockError, "'#{@product.title}' is out of stock."
    end
  end
end

class Transaction
  attr_reader :id, :customer, :product

  @@transactions = []
  @@id = 1

  def initialize(customer, product, options={})
    @customer = customer
    @product = product
    @id = @@id
    @@id += 1
    if options[:type] == 'return'
      return_transaction
    else
      add_to_transactions
    end
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

  def return_transaction
    @product.add_stock
    @@transactions << self
  end

  def add_to_transactions
    if @product.in_stock?
      @product.reduce_stock
      @@transactions << self
    else
      raise OutOfStockError, "'#{@product.title}' is out of stock."
    end
  end
end

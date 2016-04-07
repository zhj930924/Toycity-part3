class Transaction
  attr_reader :id, :customer, :product

  @@transactions = []
  @@id = 1

  def initialize(customer, product, options={})
    if product.in_stock?
      @customer = customer
      @product = product
      @id = @@id
      @@id += 1
      choose_transaction_type(options)
    else
      raise OutOfStockError, "'#{product.title}' is out of stock."
    end
  end

  def choose_transaction_type(options)
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
    @@transactions.find { |transaction| transaction.id == id }
  end

  private

  def return_transaction
    @product.add_stock
    @@transactions << self
  end

  def add_to_transactions
    @product.reduce_stock
    @@transactions << self
  end
end

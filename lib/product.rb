class Product
  attr_reader :title, :price, :stock, :promotion

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    @promotion = options[:promotion]
    check_promotion_type
    add_to_products
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
    @@products.each do |product|
      return product if product.title == title
    end
  end

  # return boolean
  def in_stock?
    @stock > 0 ? true : false
  end

  def self.in_stock
    products_in_stock = @@products.select { |product| product.in_stock? }
    products_in_stock
  end

  def reduce_stock
    @stock -= 1
  end

  def add_stock
    @stock += 1
  end

  def check_promotion_type
    if @promotion == "Black Friday"
      @price = (@price * 0.6).round(2)
    elsif @promotion == "Fool's day"
      @price = (@price * 0.000001).round(2)
      @stock = 1
    end
  end

  private

  def add_to_products
    if @@products.any? { |product| product.title == @title }
      raise DuplicateProductError, "#{@title} already exists."
    else
      @@products << self
    end
  end
end

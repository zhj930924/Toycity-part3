class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
    @@products.each do |product|
      if product.title == title
        return product
      end
    end
  end

  # return boolean
  def in_stock?
    @stock > 0 ? true : false
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

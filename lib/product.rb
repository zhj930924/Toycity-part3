class Product
  attr_reader :title

  @@products = []

  def initialize(options={})
    @title = options[:title]
    add_to_products
  end

  def self.all
    @@products
  end

  private

  def add_to_products
    # hmm...
    if @@products.each { |product| product.title == @title }
      raise DuplicateProductError, "#{@title} already exists."
    else
      @@products << self
    end
  end

end

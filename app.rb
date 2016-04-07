require_relative "lib/errors"
require_relative "lib/customer"
require_relative "lib/product"
require_relative "lib/transaction"

# PRODUCTS

Product.new(title: "LEGO Iron Man vs. Ultron", price: 22.99, stock: 55)
Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
Product.new(title: "LEGO Firehouse Headquarter", price: 199.99, stock: 0)

puts Product.all.count # Should return 3

# Product.new(title: "LEGO Iron Man vs. Ultron", price: 22.99, stock: 55)
# Should return DuplicateProductError: 'LEGO Iron Man vs. Ultron' already exists.
nanoblock = Product.find_by_title("Nano Block Empire State Building")
firehouse = Product.find_by_title("LEGO Firehouse Headquarter")

puts nanoblock.title # Should return 'Nano Block Empire State Building'
puts nanoblock.price # Should return 49.99
puts nanoblock.stock # Should return 12
puts nanoblock.in_stock? # Should return true
puts firehouse.in_stock? # Should return false

products_in_stock = Product.in_stock
# Should return an array of all products with a stock greater than zero
puts products_in_stock.include?(nanoblock) # Should return true
puts products_in_stock.include?(firehouse) # Should return false

# CUSTOMERS

Customer.new(name: "Walter Latimer")
Customer.new(name: "Julia Van Cleve")

puts Customer.all.count # Should return 2

# Customer.new(name: "Walter Latimer")
# Should return DuplicateCustomerError: 'Walter Latimer' already exists.

walter = Customer.find_by_name("Walter Latimer")

puts walter.name # Should return "Walter Latimer"

# TRANSACTIONS

transaction = Transaction.new(walter, nanoblock)

puts transaction.id # Should return 1
puts transaction.product == nanoblock # Should return true
puts transaction.product == firehouse # Should return false
puts transaction.customer == walter # Should return true

puts nanoblock.stock # Should return 11

# PURCHASES

puts walter.purchase(nanoblock)

puts Transaction.all.count # Should return 2

transaction2 = Transaction.find(2)
puts transaction2.product == nanoblock # Should return true

# walter.purchase(firehouse)
# Should return OutOfStockError: 'LEGO Firehouse Headquarter' is out of stock.

# Return
# Before return
puts nanoblock.stock # 10
puts Transaction.all.count # 2
# Execute return transaction
walter.return(nanoblock)
# After return
puts nanoblock.stock # 11 - increase by 1
puts Transaction.all.count # 3 - increase by 1

# Promotion
# Create a special product for Black Friday Sale
cheap_product = Product.new(title: "Star War Holidy Bundle", price: 99.99, stock: 25, promotion: "Black Friday")

# Is this a joke?
crazy_product = Product.new(title: "Lego Politicians", price: 999999.99, stock: 999999, promotion: "Fool's day")

# See what happens on Black Friday
puts "During #{cheap_product.promotion}, you get #{cheap_product.title} for only $#{cheap_product.price}."

# See what happens on Fool's Day
puts "During #{crazy_product.promotion}, you get #{crazy_product.title} for only $#{crazy_product.price}, but there is only #{crazy_product.stock} left!"

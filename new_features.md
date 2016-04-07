# ToyCity 3: Inventory Edition
### New Feature 1: Return

#### Product class:
* add_stock: New method to add stock by 1

#### Customer class:
* return: New method to initialize a special transaction (type = return).

#### Transaction class:
* return_transaction: New method that will be conditionally executed when transaction type is "return". It calls the add_stock method on product instance.

### New Feature 2: Promotion
#### Product class:
* check_promotion_type: Check's what kind of promition it is, and adjust price and sometimes stock accordingly.
* attr_reader: Make promotion readable by users.
* initialize: Calls check_promotion_type when promotion exists.

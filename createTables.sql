-- ### Activity: Creating an E-commerce Database Schema in MySQL
-- # This database will track customers, products, and orders. 
-- #### Instructions

CREATE DATABASE online_store;

-- Create the customers table

CREATE TABLE customers (
    customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(70),
    city VARCHAR(20),
    state VARCHAR(20),
	zip_code INT CHECK (zip_code BETWEEN 10000 AND 99999),
    date_registered TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- -- 3. **Create the Products Table**

CREATE TABLE products (
    product_ID INT auto_increment PRIMARY KEY,
    product_name VARCHAR(50),
    product_description VARCHAR(150),
    price DECIMAL(10, 2), -- 10 digits, 2 are after the decimal point
    quantity INT,
    date_indexed DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- -- 4. **Create the Orders Table**

CREATE TABLE orders(
	order_ID INT auto_increment PRIMARY KEY,
	customer_ID INT,
	FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID),
	date_ordered DATETIME DEFAULT CURRENT_TIMESTAMP,
	order_status ENUM("Pending", "Shipped", "Delivered", "Cancelled"),
	total_order_price DECIMAL(10, 2)
);

-- -- 5. **Create the Order Details Table**

CREATE TABLE order_details(
	order_detail_id INT auto_increment PRIMARY KEY,
	order_ID INT, 
	FOREIGN KEY (order_ID) REFERENCES orders(order_ID), 
	product_ID INT,
	FOREIGN KEY (product_ID) REFERENCES products(product_ID), 
	quantity_ordered INT NOT NULL,
	total_price DECIMAL(10, 2) DEFAULT NULL
);


-- -- 6. **Populate the Tables with Sample Data**
-- --    - Add items to the `order_details` table for the sample order, referencing the products in the `products` table.

INSERT INTO products
VALUES
	(DEFAULT, "Black Jean Jacket", "Black Jacket with silver studs and a crisp collar", 23.50, 7, DEFAULT),
	(DEFAULT, "Froggie Cup", "Lime green ceramic frog cup", 10, 23, DEFAULT),
    (DEFAULT, "Mixed Media Sketchbook", "Good for markers, painting. Has 100 pages.", 13.99, 13, DEFAULT),
    (DEFAULT, "Dove Body Lotion", "Lotion that locks in moisture and keeps you fresh.", 9.99, 10, DEFAULT),
    (DEFAULT, "Jeans", "Blue skinny jeans", 8, 16, DEFAULT),
    (DEFAULT, "Elden Ring Poster", "Official art from the Souls franchise", 50, 3, DEFAULT);
    
    
INSERT INTO customers 
VALUES 
	(DEFAULT, "Odessa", "Blocker", "odessablocker@gmail.com", 8161234567, "1975 Wayne Ave", "Kansas City", "Missouri", 64068, DEFAULT),
	(DEFAULT, "Jacob", "Blocker", "jblocker@gmail.com", 2677212007, "2809 Wayne Ave", "Philadelphia", "Pennslyvania", 19132, DEFAULT),
	(DEFAULT, "Missy", "Brown", "itsMimiB@gmail.com", 8013339876, "2121 N 31 St", "Miami", "Florida", 33436, DEFAULT),
	(DEFAULT, "Genesis", "Adams", "gadams@aol.com", 5614364227, "596 Holt Street", "Odessa", "Missouri", 64801, DEFAULT);

INSERT INTO orders
VALUES
    (DEFAULT, 2, DEFAULT, "Pending", NULL),
    (DEFAULT, 3, DEFAULT, "Pending", NULL),
    (DEFAULT, 1, DEFAULT, "Shipped", NULL),
    (DEFAULT, 2, DEFAULT, "Delivered", NULL),
    (DEFAULT, 1, DEFAULT, "Pending", NULL),
    (DEFAULT, 4, DEFAULT, "Delivered", NULL),
    (DEFAULT, 4, DEFAULT, "Cancelled", NULL);

INSERT INTO order_details
VALUES
	(DEFAULT, NULL, NULL, DEFAULT, 3, NULL),
    (DEFAULT, NULL, NULL, DEFAULT, 2, NULL),

-- -- 7. **Write Queries to Test Your Database**
-- --    - Retrieve all orders for a specific customer, showing only the order IDs and dates.
-- --    - Retrieve all details for a specific order, showing each product’s name, quantity, and price per item.
-- --    - Write a query to update the stock in the `products` table after an order has been placed.

-- -- 8. **Consider Enhancements (Optional)**
-- --    - How might you add a "category" column for products to categorize items in the store?
-- --    - How would you track shipment dates for orders and delivery addresses if customers have multiple addresses?

-- -- #### Reflection
-- -- - How do the tables work together to create a full picture of customers and orders?
-- -- - Why are foreign keys essential in linking different tables in a relational database?k
-- -- - What challenges did you face in designing this schema?
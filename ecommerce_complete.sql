-- E-Commerce Database for Portfolio Project
-- Database: tech_shop (Electronics & Gadgets Store with a Scranton twist!)
-- Features characters and products from The Office mixed with real tech products

CREATE DATABASE IF NOT EXISTS tech_shop;
USE tech_shop;

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE,
    customer_segment VARCHAR(20) -- VIP, Regular, New
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    price DECIMAL(10, 2),
    cost DECIMAL(10, 2),
    stock_quantity INT,
    release_date DATE
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME,
    shipping_date DATETIME,
    delivery_date DATETIME,
    order_status VARCHAR(20), -- Pending, Shipped, Delivered, Cancelled
    payment_method VARCHAR(30),
    shipping_address VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    discount_percentage DECIMAL(5, 2) DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Reviews table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =====================================================
-- SAMPLE DATA INSERTION
-- =====================================================

-- =====================================================
-- CUSTOMERS (50 total: 20 Office characters + 30 regular customers)
-- =====================================================
INSERT INTO customers (first_name, last_name, email, phone, city, country, registration_date, customer_segment) VALUES
-- THE OFFICE CHARACTERS (Scranton Branch)
('Michael', 'Scott', 'worldsbestboss@dundermifflin.com', '570-555-0101', 'Scranton', 'USA', '2023-01-15', 'VIP'),
('Jim', 'Halpert', 'jim.halpert@dundermifflin.com', '570-555-0102', 'Scranton', 'USA', '2023-02-20', 'Regular'),
('Pam', 'Beesly', 'pam.beesly@dundermifflin.com', '570-555-0103', 'Scranton', 'USA', '2023-03-10', 'Regular'),
('Dwight', 'Schrute', 'dwight.schrute@dundermifflin.com', '570-555-0104', 'Scranton', 'USA', '2023-01-25', 'VIP'),
('Angela', 'Martin', 'angela.martin@dundermifflin.com', '570-555-0105', 'Scranton', 'USA', '2023-04-05', 'Regular'),
('Stanley', 'Hudson', 'stanley.hudson@dundermifflin.com', '570-555-0107', 'Scranton', 'USA', '2023-02-28', 'VIP'),
('Phyllis', 'Vance', 'phyllis.vance@dundermifflin.com', '570-555-0108', 'Scranton', 'USA', '2023-06-18', 'Regular'),
('Kevin', 'Malone', 'kevin.malone@dundermifflin.com', '570-555-0109', 'Scranton', 'USA', '2023-03-22', 'Regular'),
('Oscar', 'Martinez', 'oscar.martinez@dundermifflin.com', '570-555-0110', 'Scranton', 'USA', '2023-07-08', 'Regular'),
('Andy', 'Bernard', 'andy.bernard@dundermifflin.com', '570-555-0111', 'Scranton', 'USA', '2023-01-30', 'VIP'),
('Kelly', 'Kapoor', 'kelly.kapoor@dundermifflin.com', '570-555-0112', 'Scranton', 'USA', '2023-08-15', 'Regular'),
('Ryan', 'Howard', 'ryan.howard@dundermifflin.com', '212-555-0113', 'New York', 'USA', '2023-04-20', 'New'),
('Toby', 'Flenderson', 'toby.flenderson@dundermifflin.com', '570-555-0114', 'Scranton', 'USA', '2023-02-14', 'New'),
('Creed', 'Bratton', 'creed.bratton@dundermifflin.com', '570-555-0115', 'Scranton', 'USA', '2023-09-01', 'Regular'),
('Meredith', 'Palmer', 'meredith.palmer@dundermifflin.com', '570-555-0116', 'Scranton', 'USA', '2023-05-25', 'Regular'),
('Darryl', 'Philbin', 'darryl.philbin@dundermifflin.com', '570-555-0117', 'Scranton', 'USA', '2023-03-18', 'VIP'),

-- THE OFFICE CHARACTERS (Other Branches & Corporate)
('Karen', 'Filippelli', 'karen.filippelli@dundermifflin.com', '315-555-0118', 'Utica', 'USA', '2023-10-12', 'Regular'),
('Jan', 'Levinson', 'jan.levinson@dundermifflin.com', '212-555-0119', 'New York', 'USA', '2023-01-08', 'VIP'),
('David', 'Wallace', 'david.wallace@dundermifflin.com', '212-555-0120', 'New York', 'USA', '2023-06-30', 'VIP'),
('Erin', 'Hannon', 'erin.hannon@dundermifflin.com', '570-555-0122', 'Scranton', 'USA', '2023-11-05', 'Regular'),

-- REGULAR CUSTOMERS (30 customers from various cities)
('Emily', 'Martinez', 'emily.m@email.com', '555-0106', 'Philadelphia', 'USA', '2023-05-12', 'Regular'),
('Mark', 'Wright', 'mwright@email.com', '555-0121', 'Washington', 'USA', '2023-04-15', 'Regular'),
('George', 'Adams', 'gadams@email.com', '555-0126', 'Portland', 'USA', '2023-08-20', 'New'),
('Carol', 'Baker', 'cbaker@email.com', '555-0127', 'Las Vegas', 'USA', '2023-03-25', 'Regular'),
('Edward', 'Nelson', 'enelson@email.com', '555-0128', 'Oklahoma City', 'USA', '2023-12-10', 'VIP'),
('Michelle', 'Carter', 'mcarter@email.com', '555-0129', 'Albuquerque', 'USA', '2023-06-15', 'Regular'),
('Jason', 'Mitchell', 'jmitchell@email.com', '555-0130', 'Tucson', 'USA', '2023-09-18', 'New'),
('Dorothy', 'Perez', 'dperez@email.com', '555-0131', 'Fresno', 'USA', '2023-04-22', 'Regular'),
('Kevin', 'Roberts', 'kroberts@email.com', '555-0132', 'Sacramento', 'USA', '2023-11-08', 'VIP'),
('Angela', 'Turner', 'aturner@email.com', '555-0133', 'Kansas City', 'USA', '2023-05-30', 'Regular'),
('Brian', 'Phillips', 'bphillips@email.com', '555-0134', 'Mesa', 'USA', '2023-07-14', 'New'),
('Helen', 'Campbell', 'hcampbell@email.com', '555-0135', 'Atlanta', 'USA', '2023-02-17', 'Regular'),
('Ronald', 'Parker', 'rparker@email.com', '555-0136', 'Colorado Springs', 'USA', '2023-10-25', 'VIP'),
('Deborah', 'Evans', 'devans@email.com', '555-0137', 'Raleigh', 'USA', '2023-08-05', 'Regular'),
('Timothy', 'Edwards', 'tedwards@email.com', '555-0138', 'Omaha', 'USA', '2023-01-20', 'New'),
('Sharon', 'Collins', 'scollins@email.com', '555-0139', 'Miami', 'USA', '2023-12-15', 'VIP'),
('Larry', 'Stewart', 'lstewart@email.com', '555-0140', 'Minneapolis', 'USA', '2023-06-28', 'Regular'),
('Ruth', 'Sanchez', 'rsanchez@email.com', '555-0141', 'Oakland', 'USA', '2023-04-10', 'Regular'),
('Jeffrey', 'Morris', 'jmorris@email.com', '555-0142', 'Tulsa', 'USA', '2023-09-22', 'New'),
('Cynthia', 'Rogers', 'crogers@email.com', '555-0143', 'Cleveland', 'USA', '2023-07-07', 'VIP'),
('Scott', 'Reed', 'sreed@email.com', '555-0144', 'Wichita', 'USA', '2023-11-30', 'Regular'),
('Kathleen', 'Cook', 'kcook@email.com', '555-0145', 'Arlington', 'USA', '2023-05-18', 'Regular'),
('Frank', 'Morgan', 'fmorgan@email.com', '555-0146', 'New Orleans', 'USA', '2023-03-05', 'New'),
('Melissa', 'Bell', 'mbell@email.com', '555-0147', 'Bakersfield', 'USA', '2023-08-28', 'Regular'),
('Gary', 'Murphy', 'gmurphy@email.com', '555-0148', 'Tampa', 'USA', '2023-02-12', 'VIP'),
('Christine', 'Bailey', 'cbailey@email.com', '555-0149', 'Honolulu', 'USA', '2023-10-03', 'Regular'),
('Brandon', 'Rivera', 'brivera@email.com', '555-0150', 'Aurora', 'USA', '2023-06-20', 'New'),
('Sarah', 'Cooper', 'scooper@email.com', '555-0151', 'Boston', 'USA', '2023-07-15', 'VIP'),
('Daniel', 'Foster', 'dfoster@email.com', '555-0152', 'Seattle', 'USA', '2023-09-10', 'Regular'),
('Lisa', 'Gray', 'lgray@email.com', '555-0153', 'Denver', 'USA', '2023-11-22', 'Regular');

-- =====================================================
-- PRODUCTS (40 total: 13 Office items + 27 tech products)
-- =====================================================
INSERT INTO products (product_name, category, brand, price, cost, stock_quantity, release_date) VALUES
-- TECH PRODUCTS - SMARTPHONES
('iPhone 14 Pro', 'Smartphones', 'Apple', 999.99, 650.00, 150, '2022-09-16'),
('Samsung Galaxy S23', 'Smartphones', 'Samsung', 899.99, 580.00, 200, '2023-02-01'),
('Google Pixel 7 Pro', 'Smartphones', 'Google', 899.99, 550.00, 160, '2022-10-13'),

-- TECH PRODUCTS - LAPTOPS
('MacBook Pro 16"', 'Laptops', 'Apple', 2499.99, 1800.00, 75, '2023-01-15'),
('Dell XPS 15', 'Laptops', 'Dell', 1799.99, 1200.00, 100, '2023-03-10'),
('Microsoft Surface Pro 9', 'Laptops', 'Microsoft', 1299.99, 850.00, 90, '2022-10-25'),

-- TECH PRODUCTS - HEADPHONES
('Sony WH-1000XM5', 'Headphones', 'Sony', 399.99, 220.00, 300, '2022-05-20'),
('AirPods Pro 2', 'Headphones', 'Apple', 249.99, 150.00, 400, '2022-09-23'),
('Bose QuietComfort 45', 'Headphones', 'Bose', 329.99, 180.00, 200, '2021-09-23'),

-- TECH PRODUCTS - TABLETS
('iPad Air', 'Tablets', 'Apple', 599.99, 380.00, 180, '2022-03-18'),
('Samsung Galaxy Tab S8', 'Tablets', 'Samsung', 699.99, 450.00, 120, '2022-02-25'),

-- THE OFFICE PRODUCTS - OFFICE SUPPLIES & NOVELTY
('Dundie Award Trophy', 'Office Supplies', 'Dunder Mifflin', 29.99, 8.00, 500, '2005-09-24'),
('World''s Best Boss Mug', 'Office Supplies', 'Dunder Mifflin', 12.99, 3.50, 1000, '2005-03-24'),
('Assistant Regional Manager Nameplate', 'Office Supplies', 'Dunder Mifflin', 34.99, 15.00, 180, '2005-03-24'),
('Stapler in Jello Kit', 'Office Pranks', 'Pranksters Inc', 24.99, 12.00, 300, '2005-10-05'),
('Prison Mike Bandana', 'Accessories', 'Dementors Inc', 9.99, 2.50, 450, '2008-11-13'),

-- TECH PRODUCTS - WEARABLES
('Apple Watch Series 8', 'Wearables', 'Apple', 399.99, 260.00, 250, '2022-09-16'),
('Fitbit Charge 5', 'Wearables', 'Fitbit', 149.99, 85.00, 350, '2021-09-27'),

-- THE OFFICE PRODUCTS - ENTERTAINMENT & HOBBIES
('Threat Level Midnight DVD', 'Movies', 'Michael Scarn Productions', 19.99, 5.00, 200, '2011-02-17'),
('Lazy Scranton DVD', 'Movies', 'SNL Productions', 9.99, 3.00, 300, '2007-10-04'),
('Beet Farm Simulator Game', 'Gaming', 'Schrute Farms', 59.99, 35.00, 150, '2008-11-20'),
('Nard Dog Banjo', 'Musical Instruments', 'Cornell Music', 449.99, 280.00, 75, '2009-09-17'),

-- TECH PRODUCTS - GAMING & ENTERTAINMENT
('Nintendo Switch OLED', 'Gaming', 'Nintendo', 349.99, 230.00, 150, '2021-10-08'),
('PlayStation 5', 'Gaming', 'Sony', 499.99, 380.00, 80, '2020-11-12'),
('Xbox Series X', 'Gaming', 'Microsoft', 499.99, 375.00, 70, '2020-11-10'),

-- THE OFFICE PRODUCTS - KITCHEN & HOME
('Pretzel Day Pretzel Maker', 'Kitchen Appliances', 'PretzelMaster', 79.99, 45.00, 250, '2011-04-28'),
('Kevin''s Famous Chili Pot', 'Kitchen Appliances', 'ChefMaster', 89.99, 50.00, 120, '2009-09-24'),
('Finer Things Club Tea Set', 'Kitchen Supplies', 'Angela''s Cats', 149.99, 85.00, 100, '2009-03-05'),

-- TECH PRODUCTS - ACCESSORIES & PERIPHERALS
('Logitech MX Master 3', 'Accessories', 'Logitech', 99.99, 55.00, 500, '2019-09-26'),
('Razer BlackWidow V3', 'Accessories', 'Razer', 139.99, 75.00, 250, '2020-08-11'),
('Samsung 1TB SSD', 'Storage', 'Samsung', 129.99, 70.00, 400, '2022-01-15'),
('Anker PowerCore 20000', 'Accessories', 'Anker', 49.99, 25.00, 600, '2020-06-10'),

-- THE OFFICE PRODUCTS - SPECIALTY
('Schrute Farms Beet Seeds', 'Garden Supplies', 'Schrute Farms', 14.99, 6.00, 800, '2005-03-24'),

-- TECH PRODUCTS - CAMERAS & AUDIO
('GoPro Hero 11', 'Cameras', 'GoPro', 499.99, 320.00, 100, '2022-09-14'),
('Canon EOS R6', 'Cameras', 'Canon', 2499.99, 1700.00, 45, '2020-08-06'),
('JBL Flip 6', 'Speakers', 'JBL', 129.99, 70.00, 300, '2021-11-01'),

-- TECH PRODUCTS - SMART HOME & MISC
('Kindle Oasis', 'E-readers', 'Amazon', 279.99, 150.00, 200, '2019-07-24'),
('Roku Streaming Stick 4K', 'Streaming Devices', 'Roku', 49.99, 28.00, 450, '2021-10-17'),
('DJI Mini 3 Pro', 'Drones', 'DJI', 759.99, 520.00, 60, '2022-05-10'),
('Oculus Quest 2', 'VR Headsets', 'Meta', 399.99, 250.00, 110, '2020-10-13');

-- =====================================================
-- ORDERS (120 orders total)
-- =====================================================
INSERT INTO orders (customer_id, order_date, shipping_date, delivery_date, order_status, payment_method, shipping_address) VALUES
-- MICHAEL SCOTT'S ORDERS (Customer ID: 1)
(1, '2024-01-05 10:30:00', '2024-01-06 09:00:00', '2024-01-10 14:20:00', 'Delivered', 'Credit Card', '1725 Slough Ave, Scranton, PA 18505'),
(1, '2024-01-18 09:15:00', '2024-01-19 08:30:00', '2024-01-23 15:45:00', 'Delivered', 'Credit Card', '1725 Slough Ave, Scranton, PA 18505'),
(1, '2024-02-14 14:30:00', '2024-02-15 09:00:00', '2024-02-19 12:00:00', 'Delivered', 'Credit Card', '1725 Slough Ave, Scranton, PA 18505'),

-- JIM HALPERT'S ORDERS (Customer ID: 2)
(2, '2024-01-08 14:15:00', '2024-01-09 08:30:00', '2024-01-13 16:45:00', 'Delivered', 'PayPal', '383 Pearl St, Scranton, PA 18503'),
(2, '2024-01-28 14:30:00', '2024-01-29 08:15:00', NULL, 'Cancelled', 'PayPal', '383 Pearl St, Scranton, PA 18503'),
(2, '2024-02-22 11:20:00', '2024-02-23 09:45:00', '2024-02-27 14:30:00', 'Delivered', 'PayPal', '383 Pearl St, Scranton, PA 18503'),

-- PAM BEESLY'S ORDERS (Customer ID: 3)
(3, '2024-01-10 09:45:00', '2024-01-11 10:00:00', '2024-01-15 11:30:00', 'Delivered', 'Credit Card', '456 Lackawanna Ave, Scranton, PA 18503'),
(3, '2024-02-10 15:30:00', '2024-02-11 08:00:00', '2024-02-15 12:15:00', 'Delivered', 'Credit Card', '456 Lackawanna Ave, Scranton, PA 18503'),

-- DWIGHT SCHRUTE'S ORDERS (Customer ID: 4)
(4, '2024-01-15 11:00:00', '2024-01-16 08:45:00', '2024-01-20 15:30:00', 'Delivered', 'Debit Card', 'Schrute Farms, RR 6, Scranton, PA 18508'),
(4, '2024-02-05 08:30:00', '2024-02-06 09:15:00', '2024-02-10 13:20:00', 'Delivered', 'Debit Card', 'Schrute Farms, RR 6, Scranton, PA 18508'),
(4, '2024-02-20 16:00:00', '2024-02-21 10:00:00', '2024-02-25 15:45:00', 'Delivered', 'Debit Card', 'Schrute Farms, RR 6, Scranton, PA 18508'),

-- ANGELA MARTIN'S ORDERS (Customer ID: 5)
(5, '2024-01-20 10:15:00', '2024-01-21 08:00:00', '2024-01-25 14:15:00', 'Delivered', 'Credit Card', '789 Oak St, Scranton, PA 18503'),
(5, '2024-02-12 13:45:00', '2024-02-13 09:30:00', '2024-02-17 16:00:00', 'Delivered', 'Credit Card', '789 Oak St, Scranton, PA 18503'),

-- STANLEY HUDSON'S ORDERS (Customer ID: 6)
(6, '2024-01-25 09:00:00', '2024-01-26 09:45:00', '2024-01-30 16:30:00', 'Delivered', 'Credit Card', '234 Elm St, Scranton, PA 18503'),
(6, '2024-02-28 10:30:00', '2024-02-29 08:15:00', '2024-03-04 14:45:00', 'Delivered', 'Credit Card', '234 Elm St, Scranton, PA 18503'),

-- PHYLLIS VANCE'S ORDERS (Customer ID: 7)
(7, '2024-01-22 15:45:00', '2024-01-23 10:30:00', '2024-01-27 12:00:00', 'Delivered', 'Credit Card', '555 Main St, Scranton, PA 18503'),

-- KEVIN MALONE'S ORDERS (Customer ID: 8)
(8, '2024-02-01 10:45:00', '2024-02-02 09:00:00', '2024-02-06 13:45:00', 'Delivered', 'Debit Card', '678 Pine St, Scranton, PA 18503'),

-- OSCAR MARTINEZ'S ORDERS (Customer ID: 9)
(9, '2024-02-03 16:00:00', '2024-02-04 10:15:00', '2024-02-08 15:30:00', 'Delivered', 'Credit Card', '321 Maple Ave, Scranton, PA 18503'),

-- ANDY BERNARD'S ORDERS (Customer ID: 10)
(10, '2024-02-05 11:30:00', '2024-02-06 08:45:00', '2024-02-10 15:00:00', 'Delivered', 'Credit Card', '852 Poplar Ln, Scranton, PA 18503'),
(10, '2024-02-18 14:45:00', '2024-02-19 08:30:00', '2024-02-23 13:30:00', 'Delivered', 'Credit Card', '852 Poplar Ln, Scranton, PA 18503'),

-- KELLY KAPOOR'S ORDERS (Customer ID: 11)
(11, '2024-02-08 13:15:00', '2024-02-09 09:30:00', '2024-02-13 14:30:00', 'Delivered', 'PayPal', '963 Hickory Ave, Scranton, PA 18503'),

-- RYAN HOWARD'S ORDERS (Customer ID: 12)
(12, '2024-02-15 10:20:00', '2024-02-16 09:15:00', '2024-02-20 16:00:00', 'Delivered', 'Credit Card', '1540 Broadway, New York, NY 10036'),

-- TOBY FLENDERSON'S ORDERS (Customer ID: 13)
(13, '2024-02-12 15:00:00', NULL, NULL, 'Pending', 'Credit Card', '159 Walnut St, Scranton, PA 18503'),

-- CREED BRATTON'S ORDERS (Customer ID: 14)
(14, '2024-01-30 09:30:00', '2024-01-31 10:00:00', '2024-02-04 14:20:00', 'Delivered', 'Cash', '777 Mystery Ln, Scranton, PA 18503'),

-- MEREDITH PALMER'S ORDERS (Customer ID: 15)
(15, '2024-02-16 16:30:00', '2024-02-17 09:00:00', '2024-02-21 13:15:00', 'Delivered', 'Debit Card', '444 River Rd, Scranton, PA 18503'),

-- DARRYL PHILBIN'S ORDERS (Customer ID: 16)
(16, '2024-02-22 11:45:00', '2024-02-23 09:45:00', NULL, 'Shipped', 'PayPal', '951 Sycamore Ln, Scranton, PA 18503'),

-- KAREN FILIPPELLI'S ORDERS (Customer ID: 17)
(17, '2024-01-12 13:20:00', '2024-01-13 09:00:00', '2024-01-17 15:30:00', 'Delivered', 'Credit Card', '2356 Genesee St, Utica, NY 13501'),

-- JAN LEVINSON'S ORDERS (Customer ID: 18)
(18, '2024-01-16 10:45:00', '2024-01-17 08:30:00', '2024-01-21 14:00:00', 'Delivered', 'Credit Card', '890 Park Ave, New York, NY 10021'),

-- DAVID WALLACE'S ORDERS (Customer ID: 19)
(19, '2024-01-20 11:15:00', '2024-01-21 10:00:00', '2024-01-25 15:45:00', 'Delivered', 'Credit Card', '1234 Madison Ave, New York, NY 10128'),

-- ERIN HANNON'S ORDERS (Customer ID: 20)
(20, '2024-02-25 13:30:00', '2024-02-26 09:15:00', '2024-03-01 16:20:00', 'Delivered', 'Debit Card', '246 Cherry St, Scranton, PA 18503');

-- REGULAR CUSTOMER ORDERS (100 more orders from customer ID 21-50)
INSERT INTO orders (customer_id, order_date, shipping_date, delivery_date, order_status, payment_method, shipping_address) VALUES
(21, '2024-01-07 09:20:00', '2024-01-08 08:45:00', '2024-01-12 14:30:00', 'Delivered', 'Credit Card', '123 Market St, Philadelphia, PA'),
(22, '2024-01-09 14:35:00', '2024-01-10 09:15:00', '2024-01-14 16:00:00', 'Delivered', 'PayPal', '456 Capitol Hill, Washington, DC'),
(23, '2024-01-11 11:50:00', '2024-01-12 10:20:00', '2024-01-16 13:45:00', 'Delivered', 'Credit Card', '789 SW Broadway, Portland, OR'),
(24, '2024-01-13 15:10:00', '2024-01-14 09:30:00', '2024-01-18 15:20:00', 'Delivered', 'Debit Card', '321 Fremont St, Las Vegas, NV'),
(25, '2024-01-17 10:25:00', '2024-01-18 08:50:00', '2024-01-22 14:15:00', 'Delivered', 'Credit Card', '654 N Robinson Ave, Oklahoma City, OK'),
(26, '2024-01-19 13:40:00', '2024-01-20 09:10:00', '2024-01-24 16:30:00', 'Delivered', 'PayPal', '987 Central Ave NW, Albuquerque, NM'),
(27, '2024-01-21 16:55:00', '2024-01-22 10:05:00', '2024-01-26 13:50:00', 'Delivered', 'Credit Card', '147 E Congress St, Tucson, AZ'),
(28, '2024-01-23 09:15:00', '2024-01-24 08:30:00', '2024-01-28 15:10:00', 'Delivered', 'Debit Card', '258 N Blackstone Ave, Fresno, CA'),
(29, '2024-01-26 12:30:00', '2024-01-27 09:45:00', '2024-01-31 16:25:00', 'Delivered', 'Credit Card', '369 J St, Sacramento, CA'),
(30, '2024-01-29 14:45:00', '2024-01-30 10:00:00', '2024-02-03 13:35:00', 'Delivered', 'PayPal', '741 Main St, Kansas City, MO'),
(31, '2024-02-02 11:20:00', '2024-02-03 09:15:00', '2024-02-07 15:50:00', 'Delivered', 'Credit Card', '852 W University Dr, Mesa, AZ'),
(32, '2024-02-04 15:35:00', '2024-02-05 10:30:00', '2024-02-09 14:10:00', 'Delivered', 'Debit Card', '963 Peachtree St, Atlanta, GA'),
(33, '2024-02-07 09:50:00', '2024-02-08 08:20:00', '2024-02-12 16:45:00', 'Delivered', 'Credit Card', '159 E Pikes Peak Ave, Colorado Springs, CO'),
(34, '2024-02-09 13:05:00', '2024-02-10 09:40:00', '2024-02-14 15:25:00', 'Delivered', 'PayPal', '357 Fayetteville St, Raleigh, NC'),
(35, '2024-02-11 16:20:00', '2024-02-12 10:55:00', '2024-02-16 13:00:00', 'Delivered', 'Credit Card', '753 Dodge St, Omaha, NE'),
(36, '2024-02-14 10:40:00', '2024-02-15 09:05:00', '2024-02-19 15:40:00', 'Delivered', 'Debit Card', '951 Biscayne Blvd, Miami, FL'),
(37, '2024-02-17 14:55:00', '2024-02-18 10:20:00', '2024-02-22 14:15:00', 'Delivered', 'Credit Card', '246 Hennepin Ave, Minneapolis, MN'),
(38, '2024-02-19 11:10:00', '2024-02-20 08:45:00', '2024-02-24 16:30:00', 'Delivered', 'PayPal', '468 Broadway, Oakland, CA'),
(39, '2024-02-21 15:25:00', '2024-02-22 09:50:00', '2024-02-26 13:45:00', 'Delivered', 'Credit Card', '579 S Boulder Ave, Tulsa, OK'),
(40, '2024-02-23 09:40:00', '2024-02-24 08:15:00', '2024-02-28 15:20:00', 'Delivered', 'Debit Card', '680 Euclid Ave, Cleveland, OH'),
(41, '2024-02-26 13:55:00', '2024-02-27 09:30:00', '2024-03-02 16:05:00', 'Delivered', 'Credit Card', '791 E Douglas Ave, Wichita, KS'),
(42, '2024-02-28 16:10:00', '2024-02-29 10:45:00', '2024-03-04 14:50:00', 'Delivered', 'PayPal', '802 S Cooper St, Arlington, TX'),
(43, '2024-03-01 10:25:00', '2024-03-02 09:00:00', '2024-03-06 15:35:00', 'Delivered', 'Credit Card', '913 Canal St, New Orleans, LA'),
(44, '2024-03-03 14:40:00', '2024-03-04 10:15:00', '2024-03-08 13:20:00', 'Delivered', 'Debit Card', '124 Chester Ave, Bakersfield, CA'),
(45, '2024-03-05 11:55:00', '2024-03-06 09:30:00', '2024-03-10 16:10:00', 'Delivered', 'Credit Card', '235 Kennedy Blvd, Tampa, FL'),
(46, '2024-03-07 15:10:00', '2024-03-08 10:45:00', '2024-03-12 14:55:00', 'Delivered', 'PayPal', '346 S King St, Honolulu, HI'),
(47, '2024-03-09 09:25:00', '2024-03-10 08:00:00', '2024-03-14 15:40:00', 'Delivered', 'Credit Card', '457 E Colfax Ave, Aurora, CO'),
(48, '2024-03-11 13:40:00', '2024-03-12 09:15:00', '2024-03-16 16:25:00', 'Delivered', 'Debit Card', '568 Boylston St, Boston, MA'),
(49, '2024-03-13 16:55:00', '2024-03-14 10:30:00', '2024-03-18 13:10:00', 'Delivered', 'Credit Card', '679 Pike St, Seattle, WA'),
(50, '2024-03-15 10:10:00', '2024-03-16 08:45:00', '2024-03-20 15:55:00', 'Delivered', 'PayPal', '780 16th St, Denver, CO'),
(21, '2024-03-17 14:25:00', '2024-03-18 09:00:00', '2024-03-22 16:40:00', 'Delivered', 'Credit Card', '123 Market St, Philadelphia, PA'),
(22, '2024-03-19 11:40:00', '2024-03-20 10:15:00', '2024-03-24 14:25:00', 'Delivered', 'Debit Card', '456 Capitol Hill, Washington, DC'),
(23, '2024-03-21 15:55:00', '2024-03-22 09:30:00', '2024-03-26 16:10:00', 'Delivered', 'PayPal', '789 SW Broadway, Portland, OR'),
(24, '2024-03-23 09:10:00', '2024-03-24 08:45:00', '2024-03-28 15:55:00', 'Delivered', 'Credit Card', '321 Fremont St, Las Vegas, NV'),
(25, '2024-03-25 13:25:00', '2024-03-26 10:00:00', '2024-03-30 14:40:00', 'Delivered', 'Debit Card', '654 N Robinson Ave, Oklahoma City, OK'),
(26, '2024-03-27 16:40:00', '2024-03-28 09:15:00', '2024-04-01 16:25:00', 'Delivered', 'Credit Card', '987 Central Ave NW, Albuquerque, NM'),
(27, '2024-03-29 10:55:00', '2024-03-30 08:30:00', NULL, 'Shipped', 'PayPal', '147 E Congress St, Tucson, AZ'),
(28, '2024-03-31 14:10:00', '2024-04-01 10:45:00', NULL, 'Shipped', 'Debit Card', '258 N Blackstone Ave, Fresno, CA'),
(29, '2024-04-02 11:25:00', NULL, NULL, 'Pending', 'Credit Card', '369 J St, Sacramento, CA'),
(30, '2024-04-04 15:40:00', NULL, NULL, 'Pending', 'PayPal', '741 Main St, Kansas City, MO'),
(31, '2024-04-06 09:55:00', NULL, NULL, 'Pending', 'Credit Card', '852 W University Dr, Mesa, AZ'),
(32, '2024-01-14 13:10:00', '2024-01-15 09:25:00', '2024-01-19 16:10:00', 'Delivered', 'Debit Card', '963 Peachtree St, Atlanta, GA'),
(33, '2024-01-24 16:25:00', '2024-01-25 10:40:00', '2024-01-29 14:55:00', 'Delivered', 'Credit Card', '159 E Pikes Peak Ave, Colorado Springs, CO'),
(34, '2024-02-05 10:40:00', '2024-02-06 09:55:00', '2024-02-10 16:40:00', 'Delivered', 'PayPal', '357 Fayetteville St, Raleigh, NC'),
(35, '2024-02-15 14:55:00', '2024-02-16 10:10:00', '2024-02-20 15:25:00', 'Delivered', 'Credit Card', '753 Dodge St, Omaha, NE'),
(36, '2024-02-25 11:10:00', '2024-02-26 09:25:00', '2024-03-01 16:10:00', 'Delivered', 'Debit Card', '951 Biscayne Blvd, Miami, FL'),
(37, '2024-03-07 15:25:00', '2024-03-08 10:40:00', '2024-03-12 14:55:00', 'Delivered', 'PayPal', '246 Hennepin Ave, Minneapolis, MN'),
(38, '2024-03-17 11:40:00', '2024-03-18 09:55:00', '2024-03-22 16:40:00', 'Delivered', 'Credit Card', '468 Broadway, Oakland, CA'),
(39, '2024-03-27 15:55:00', '2024-03-28 10:10:00', NULL, 'Shipped', 'Debit Card', '579 S Boulder Ave, Tulsa, OK'),
(40, '2024-01-27 10:10:00', '2024-01-28 08:25:00', '2024-02-01 15:10:00', 'Delivered', 'PayPal', '680 Euclid Ave, Cleveland, OH'),
(41, '2024-02-06 14:25:00', '2024-02-07 09:40:00', '2024-02-11 16:25:00', 'Delivered', 'Credit Card', '791 E Douglas Ave, Wichita, KS'),
(42, '2024-02-16 11:40:00', '2024-02-17 10:55:00', '2024-02-21 14:10:00', 'Delivered', 'Debit Card', '802 S Cooper St, Arlington, TX'),
(43, '2024-02-26 15:55:00', '2024-02-27 09:10:00', '2024-03-02 16:55:00', 'Delivered', 'PayPal', '913 Canal St, New Orleans, LA'),
(44, '2024-03-08 10:10:00', '2024-03-09 08:25:00', '2024-03-13 15:40:00', 'Delivered', 'Credit Card', '124 Chester Ave, Bakersfield, CA'),
(45, '2024-03-18 14:25:00', '2024-03-19 09:40:00', '2024-03-23 16:25:00', 'Delivered', 'Debit Card', '235 Kennedy Blvd, Tampa, FL'),
(46, '2024-03-28 11:40:00', '2024-03-29 10:55:00', NULL, 'Shipped', 'Credit Card', '346 S King St, Honolulu, HI'),
(47, '2024-01-08 15:55:00', '2024-01-09 09:10:00', '2024-01-13 16:55:00', 'Delivered', 'PayPal', '457 E Colfax Ave, Aurora, CO'),
(48, '2024-01-18 10:10:00', '2024-01-19 08:25:00', '2024-01-23 15:40:00', 'Delivered', 'Debit Card', '568 Boylston St, Boston, MA'),
(49, '2024-01-28 14:25:00', '2024-01-29 09:40:00', '2024-02-02 16:25:00', 'Delivered', 'Credit Card', '679 Pike St, Seattle, WA'),
(50, '2024-02-07 11:40:00', '2024-02-08 10:55:00', '2024-02-12 14:10:00', 'Delivered', 'PayPal', '780 16th St, Denver, CO'),
(21, '2024-02-17 15:55:00', '2024-02-18 09:10:00', '2024-02-22 16:55:00', 'Delivered', 'Credit Card', '123 Market St, Philadelphia, PA'),
(22, '2024-02-27 10:10:00', '2024-02-28 08:25:00', '2024-03-03 15:40:00', 'Delivered', 'Debit Card', '456 Capitol Hill, Washington, DC'),
(23, '2024-03-09 14:25:00', '2024-03-10 09:40:00', '2024-03-14 16:25:00', 'Delivered', 'PayPal', '789 SW Broadway, Portland, OR'),
(24, '2024-03-19 11:40:00', '2024-03-20 10:55:00', '2024-03-24 14:10:00', 'Delivered', 'Credit Card', '321 Fremont St, Las Vegas, NV'),
(25, '2024-03-29 15:55:00', '2024-03-30 09:10:00', NULL, 'Shipped', 'Debit Card', '654 N Robinson Ave, Oklahoma City, OK'),
(26, '2024-01-10 10:10:00', '2024-01-11 08:25:00', '2024-01-15 15:40:00', 'Delivered', 'PayPal', '987 Central Ave NW, Albuquerque, NM'),
(27, '2024-01-20 14:25:00', '2024-01-21 09:40:00', '2024-01-25 16:25:00', 'Delivered', 'Credit Card', '147 E Congress St, Tucson, AZ'),
(28, '2024-01-30 11:40:00', '2024-01-31 10:55:00', '2024-02-04 14:10:00', 'Delivered', 'Debit Card', '258 N Blackstone Ave, Fresno, CA'),
(29, '2024-02-09 15:55:00', '2024-02-10 09:10:00', '2024-02-14 16:55:00', 'Delivered', 'Credit Card', '369 J St, Sacramento, CA'),
(30, '2024-02-19 10:10:00', '2024-02-20 08:25:00', '2024-02-24 15:40:00', 'Delivered', 'PayPal', '741 Main St, Kansas City, MO'),
(31, '2024-02-29 14:25:00', '2024-03-01 09:40:00', '2024-03-05 16:25:00', 'Delivered', 'Debit Card', '852 W University Dr, Mesa, AZ'),
(32, '2024-03-10 11:40:00', '2024-03-11 10:55:00', '2024-03-15 14:10:00', 'Delivered', 'Credit Card', '963 Peachtree St, Atlanta, GA'),
(33, '2024-03-20 15:55:00', '2024-03-21 09:10:00', '2024-03-25 16:55:00', 'Delivered', 'PayPal', '159 E Pikes Peak Ave, Colorado Springs, CO'),
(34, '2024-03-30 10:10:00', NULL, NULL, 'Pending', 'Debit Card', '357 Fayetteville St, Raleigh, NC'),
(35, '2024-01-22 14:25:00', '2024-01-23 09:40:00', '2024-01-27 16:25:00', 'Delivered', 'Credit Card', '753 Dodge St, Omaha, NE'),
(36, '2024-02-01 11:40:00', '2024-02-02 10:55:00', '2024-02-06 14:10:00', 'Delivered', 'PayPal', '951 Biscayne Blvd, Miami, FL'),
(37, '2024-02-11 15:55:00', '2024-02-12 09:10:00', '2024-02-16 16:55:00', 'Delivered', 'Debit Card', '246 Hennepin Ave, Minneapolis, MN'),
(38, '2024-02-21 10:10:00', '2024-02-22 08:25:00', '2024-02-26 15:40:00', 'Delivered', 'Credit Card', '468 Broadway, Oakland, CA'),
(39, '2024-03-03 14:25:00', '2024-03-04 09:40:00', '2024-03-08 16:25:00', 'Delivered', 'PayPal', '579 S Boulder Ave, Tulsa, OK'),
(40, '2024-03-13 11:40:00', '2024-03-14 10:55:00', '2024-03-18 14:10:00', 'Delivered', 'Debit Card', '680 Euclid Ave, Cleveland, OH'),
(41, '2024-03-23 15:55:00', '2024-03-24 09:10:00', '2024-03-28 16:55:00', 'Delivered', 'Credit Card', '791 E Douglas Ave, Wichita, KS'),
(42, '2024-04-02 10:10:00', NULL, NULL, 'Pending', 'PayPal', '802 S Cooper St, Arlington, TX'),
(43, '2024-01-12 14:25:00', '2024-01-13 09:40:00', '2024-01-17 16:25:00', 'Delivered', 'Debit Card', '913 Canal St, New Orleans, LA'),
(44, '2024-01-22 11:40:00', '2024-01-23 10:55:00', '2024-01-27 14:10:00', 'Delivered', 'Credit Card', '124 Chester Ave, Bakersfield, CA'),
(45, '2024-02-01 15:55:00', '2024-02-02 09:10:00', '2024-02-06 16:55:00', 'Delivered', 'PayPal', '235 Kennedy Blvd, Tampa, FL'),
(46, '2024-02-11 10:10:00', '2024-02-12 08:25:00', '2024-02-16 15:40:00', 'Delivered', 'Debit Card', '346 S King St, Honolulu, HI'),
(47, '2024-02-21 14:25:00', '2024-02-22 09:40:00', '2024-02-26 16:25:00', 'Delivered', 'Credit Card', '457 E Colfax Ave, Aurora, CO'),
(48, '2024-03-03 11:40:00', '2024-03-04 10:55:00', '2024-03-08 14:10:00', 'Delivered', 'PayPal', '568 Boylston St, Boston, MA'),
(49, '2024-03-13 15:55:00', '2024-03-14 09:10:00', '2024-03-18 16:55:00', 'Delivered', 'Debit Card', '679 Pike St, Seattle, WA'),
(50, '2024-03-23 10:10:00', '2024-03-24 08:25:00', '2024-03-28 15:40:00', 'Delivered', 'Credit Card', '780 16th St, Denver, CO');

-- =====================================================
-- ORDER ITEMS (Detailed purchases with Office character patterns)
-- =====================================================
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percentage) VALUES
-- Order 1: Michael Scott's first order - iPhone + World's Best Boss Mugs in bulk
(1, 1, 1, 999.99, 0),
(1, 13, 5, 12.99, 0),

-- Order 2: Michael Scott - More Dundies and Boss Mugs
(2, 12, 3, 29.99, 5),
(2, 13, 2, 12.99, 0),
(2, 18, 1, 19.99, 0),

-- Order 3: Michael Scott - Threat Level Midnight screening party
(3, 18, 10, 19.99, 10),
(3, 16, 1, 9.99, 0),

-- Order 4: Jim Halpert - MacBook Pro for work
(4, 4, 1, 2499.99, 10),

-- Order 5: Jim Halpert - Cancelled order (probably changed his mind)
(5, 2, 1, 899.99, 0),

-- Order 6: Jim Halpert - Prank supplies!
(6, 15, 3, 24.99, 0),
(6, 28, 1, 99.99, 0),

-- Order 7: Pam Beesly - Smartphone upgrade
(7, 2, 1, 899.99, 0),
(7, 28, 2, 99.99, 0),

-- Order 8: Pam Beesly - Tablet for artwork
(8, 10, 1, 599.99, 0),

-- Order 9: Dwight Schrute - 50 BEET SEED PACKAGES!
(9, 32, 50, 14.99, 5),
(9, 20, 1, 59.99, 0),

-- Order 10: Dwight Schrute - Assistant Regional Manager Nameplate
(10, 14, 1, 34.99, 0),
(10, 5, 1, 1799.99, 8),

-- Order 11: Dwight Schrute - Security equipment
(11, 33, 1, 499.99, 0),

-- Order 12: Angela Martin - Finer Things Club Tea Set
(12, 26, 1, 149.99, 0),
(12, 11, 1, 699.99, 5),

-- Order 13: Angela Martin - More cat supplies (and tech)
(13, 10, 1, 599.99, 0),

-- Order 14: Stanley Hudson - PRETZEL DAY PRETZEL MAKER!
(14, 25, 1, 79.99, 0),
(14, 38, 1, 49.99, 0),

-- Order 15: Stanley Hudson - Headphones (to ignore everyone)
(15, 9, 1, 329.99, 0),

-- Order 16: Phyllis Vance - Laptop for Bob Vance, Vance Refrigeration
(16, 5, 1, 1799.99, 8),

-- Order 17: Kevin Malone - Kevin's Famous Chili Pot
(17, 26, 1, 89.99, 0),
(17, 17, 1, 149.99, 10),

-- Order 18: Oscar Martinez - iPad for budgeting
(18, 10, 1, 599.99, 0),

-- Order 19: Andy Bernard - Nard Dog Banjo!
(19, 21, 1, 449.99, 0),
(19, 29, 1, 139.99, 0),

-- Order 20: Andy Bernard - More Cornell merch
(20, 1, 1, 999.99, 0),

-- Order 21: Kelly Kapoor - Latest tech and fashion
(21, 11, 1, 699.99, 5),
(21, 8, 2, 249.99, 0),

-- Order 22: Ryan Howard - Threat Level Midnight DVD
(22, 18, 1, 19.99, 0),
(22, 6, 1, 1299.99, 10),

-- Order 23: Toby Flenderson - Pending order
(23, 37, 1, 279.99, 0),

-- Order 24: Creed Bratton - Mystery order (who knows what Creed does)
(24, 31, 1, 49.99, 0),
(24, 16, 1, 9.99, 0),

-- Order 25: Meredith Palmer - Power bank for her van
(25, 31, 2, 49.99, 0),

-- Order 26: Darryl Philbin - Gaming console for warehouse breaks
(26, 22, 1, 349.99, 0),

-- Order 27: Karen Filippelli - Professional laptop setup
(27, 4, 1, 2499.99, 0),

-- Order 28: Jan Levinson - High-end everything
(28, 4, 1, 2499.99, 5),
(28, 16, 1, 399.99, 0),

-- Order 29: David Wallace - CFO needs the best
(29, 4, 1, 2499.99, 0),
(29, 34, 1, 2499.99, 0),

-- Order 30: Erin Hannon - Basic tech
(30, 19, 1, 9.99, 0),
(30, 17, 1, 149.99, 10);

-- Regular customer orders (Orders 31-120)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percentage) VALUES
(31, 1, 1, 999.99, 0),
(32, 4, 1, 2499.99, 5),
(33, 7, 1, 399.99, 0),
(34, 22, 1, 349.99, 0),
(35, 3, 1, 899.99, 5),
(36, 10, 1, 599.99, 0),
(37, 23, 1, 499.99, 0),
(38, 5, 1, 1799.99, 8),
(39, 11, 1, 699.99, 5),
(40, 33, 1, 499.99, 0),
(41, 2, 1, 899.99, 0),
(42, 16, 1, 399.99, 0),
(43, 28, 2, 99.99, 0),
(44, 8, 2, 249.99, 5),
(45, 35, 1, 759.99, 0),
(46, 24, 1, 499.99, 0),
(47, 30, 1, 129.99, 0),
(48, 31, 1, 49.99, 0),
(49, 17, 1, 149.99, 10),
(50, 29, 1, 139.99, 0),
(51, 7, 1, 399.99, 0),
(52, 1, 1, 999.99, 0),
(53, 4, 1, 2499.99, 10),
(54, 22, 1, 349.99, 0),
(55, 10, 1, 599.99, 0),
(56, 5, 1, 1799.99, 5),
(57, 34, 1, 2499.99, 0),
(58, 38, 1, 49.99, 0),
(59, 37, 1, 279.99, 0),
(60, 28, 1, 99.99, 0),
(61, 11, 1, 699.99, 5),
(62, 2, 1, 899.99, 0),
(63, 16, 1, 399.99, 0),
(64, 23, 1, 499.99, 0),
(65, 8, 1, 249.99, 0),
(66, 7, 1, 399.99, 0),
(67, 35, 1, 759.99, 5),
(68, 3, 1, 899.99, 0),
(69, 30, 1, 129.99, 0),
(70, 1, 1, 999.99, 5),
(71, 10, 1, 599.99, 0),
(72, 4, 1, 2499.99, 0),
(73, 24, 1, 499.99, 0),
(74, 22, 1, 349.99, 0),
(75, 5, 1, 1799.99, 8),
(76, 33, 1, 499.99, 0),
(77, 11, 1, 699.99, 0),
(78, 17, 1, 149.99, 5),
(79, 29, 1, 139.99, 0),
(80, 31, 2, 49.99, 0),
(81, 2, 1, 899.99, 0),
(82, 7, 1, 399.99, 0),
(83, 16, 1, 399.99, 5),
(84, 10, 1, 599.99, 0),
(85, 8, 2, 249.99, 0),
(86, 28, 1, 99.99, 0),
(87, 1, 1, 999.99, 0),
(88, 30, 1, 129.99, 0),
(89, 4, 1, 2499.99, 10),
(90, 22, 1, 349.99, 0),
(91, 23, 1, 499.99, 0),
(92, 5, 1, 1799.99, 5),
(93, 11, 1, 699.99, 0),
(94, 3, 1, 899.99, 0),
(95, 35, 1, 759.99, 5),
(96, 24, 1, 499.99, 0),
(97, 37, 1, 279.99, 0),
(98, 38, 1, 49.99, 0),
(99, 17, 1, 149.99, 10),
(100, 29, 1, 139.99, 0),
(101, 7, 1, 399.99, 0),
(102, 2, 1, 899.99, 5),
(103, 16, 1, 399.99, 0),
(104, 10, 1, 599.99, 0),
(105, 1, 1, 999.99, 0),
(106, 4, 1, 2499.99, 0),
(107, 8, 1, 249.99, 5),
(108, 28, 2, 99.99, 0),
(109, 30, 1, 129.99, 0),
(110, 31, 1, 49.99, 0),
(111, 22, 1, 349.99, 0),
(112, 5, 1, 1799.99, 8),
(113, 11, 1, 699.99, 5),
(114, 33, 1, 499.99, 0),
(115, 23, 1, 499.99, 0),
(116, 3, 1, 899.99, 0),
(117, 17, 1, 149.99, 0),
(118, 7, 1, 399.99, 5),
(119, 35, 1, 759.99, 0),
(120, 24, 1, 499.99, 0);

-- =====================================================
-- REVIEWS (Featuring Office character personalities!)
-- =====================================================
INSERT INTO reviews (product_id, customer_id, rating, review_text, review_date) VALUES
-- MICHAEL SCOTT'S REVIEWS
(1, 1, 5, 'Amazing phone! Camera quality is outstanding for filming Threat Level Midnight 2.', '2024-01-15'),
(12, 1, 5, 'Ordered 3 for the office. Everyone loves them! #DundiesForAll', '2024-01-22'),
(13, 1, 5, 'Best mug ever. Really shows who is in charge! Bought 5 more for backup.', '2024-01-25'),
(18, 1, 5, 'My masterpiece! Everyone should own a copy. Golden Globes here we come!', '2024-02-20'),

-- JIM HALPERT'S REVIEWS
(2, 2, 5, 'Best Android phone I have owned! Perfect for filming pranks in 4K.', '2024-01-18'),
(13, 2, 1, 'Bought as a gag gift... boss took it seriously and now wears it proudly. Backfired.', '2024-01-30'),
(15, 2, 5, 'Perfect for pranking coworkers. Highly recommend! Dwight never saw it coming.', '2024-02-28'),
(4, 2, 5, 'Great laptop for "working from home" aka playing games. Pam approved!', '2024-02-05'),

-- PAM BEESLY'S REVIEWS  
(2, 3, 4, 'Great device but took a while to get used to after my flip phone.', '2024-01-20'),
(10, 3, 5, 'Perfect tablet for digital art! Much better than reception desk doodling.', '2024-02-20'),

-- DWIGHT SCHRUTE'S REVIEWS
(20, 4, 4, 'Fun game but beets are harder to farm than expected. Not as realistic as actual farming.', '2024-01-30'),
(14, 4, 5, 'Finally got the recognition I deserve! Assistant TO THE Regional Manager.', '2024-02-12'),
(32, 4, 5, 'Excellent yield. Beets are the best vegetable. Bears eat beets. Battlestar Galactica.', '2024-02-25'),
(5, 4, 4, 'Good laptop but I prefer my typewriter for official Schrute Farms business.', '2024-02-28'),

-- ANGELA MARTIN'S REVIEWS
(26, 5, 5, 'Sophisticated and elegant. Perfect for discussing literature with Oscar and Toby.', '2024-02-18'),
(11, 5, 5, 'Excellent tablet for church group presentations and cat photos.', '2024-02-20'),

-- STANLEY HUDSON'S REVIEWS
(25, 6, 5, 'This is the best thing since retirement. Pretzel Day every day! IT IS PRETZEL DAY!', '2024-02-10'),
(9, 6, 5, 'Great headphones for drowning out Michael and his nonsense.', '2024-03-08'),
(38, 6, 4, 'Works well for Florida Days. Reliable streaming.', '2024-03-10'),

-- PHYLLIS VANCE'S REVIEWS
(5, 7, 5, 'Bob Vance, Vance Refrigeration loves this laptop!', '2024-02-05'),

-- KEVIN MALONE'S REVIEWS
(26, 8, 1, 'Spilled all over the carpet. Total disaster. The trick is to undercook the onions...', '2024-02-12'),
(17, 8, 3, 'Comfortable but hard to type while eating M&Ms.', '2024-02-15'),

-- OSCAR MARTINEZ'S REVIEWS
(10, 9, 5, 'Excellent for budgeting spreadsheets. Actually, the correct depreciation formula is...', '2024-02-18'),

-- ANDY BERNARD'S REVIEWS
(21, 10, 5, 'Cornell quality. Great for serenading the office. Ri-dit-dit-di-doo!', '2024-02-20'),
(1, 10, 4, 'Good phone but not as good as the one I had at Cornell. Go Big Red!', '2024-02-28'),

-- KELLY KAPOOR'S REVIEWS
(11, 11, 5, 'OMG this tablet is literally perfect for watching The Mindy Project!', '2024-02-22'),
(8, 11, 5, 'These AirPods are so cute! Ryan better get me the pink case for our anniversary!', '2024-02-25'),

-- RYAN HOWARD'S REVIEWS
(18, 12, 5, 'The best action movie ever made. Michael Scarn is a legend! Better than Bond.', '2024-02-28'),
(6, 12, 4, 'Good laptop for my startup. WUPHF.com is going to change everything!', '2024-03-05'),

-- CREED BRATTON'S REVIEWS
(31, 14, 5, 'Perfect for my... activities. No further questions.', '2024-02-10'),
(16, 14, 5, 'The Dementors are real, man. This bandana protects me.', '2024-02-15'),

-- MEREDITH PALMER'S REVIEWS
(31, 15, 4, 'Charges my phone in the van perfectly. Great for... long nights.', '2024-02-25'),

-- DARRYL PHILBIN'S REVIEWS
(22, 16, 5, 'Gaming console is awesome! Finally something fun in the warehouse.', '2024-03-01'),

-- KAREN FILIPPELLI'S REVIEWS
(4, 17, 5, 'Professional quality. Much better than what I had in Scranton.', '2024-01-25'),

-- JAN LEVINSON'S REVIEWS
(4, 18, 5, 'Excellent laptop for running my candle business. Serenity by Jan needs the best!', '2024-01-28'),
(16, 18, 4, 'Good watch but I prefer the space heater in my office.', '2024-02-05'),

-- DAVID WALLACE'S REVIEWS
(4, 19, 5, 'Top-tier laptop for CFO work. Handles Suck It development perfectly.', '2024-02-01'),
(34, 19, 5, 'Professional camera quality. Great for family photos with Teddy!', '2024-02-10'),

-- ERIN HANNON'S REVIEWS
(19, 20, 4, 'Super cute bandana! Reminds me of Florida!', '2024-03-05'),
(17, 20, 5, 'Yay! These are so comfy! Perfect for being secretary!', '2024-03-08'),

-- REGULAR CUSTOMER REVIEWS (adding variety)
(7, 21, 5, 'Best noise cancellation ever! Worth every penny.', '2024-01-20'),
(22, 23, 5, 'Gaming experience is incredible! My kids love it.', '2024-02-25'),
(23, 24, 4, 'Great console, wish more were in stock earlier.', '2024-03-01'),
(33, 27, 5, 'Perfect for travel vlogging! Amazing quality.', '2024-02-15'),
(35, 28, 5, 'Easy to fly, amazing video quality. Best purchase this year.', '2024-03-10'),
(28, 30, 5, 'Best mouse I have ever used! So smooth.', '2024-03-05'),
(3, 32, 5, 'Best camera on any smartphone. Night mode is insane!', '2024-02-28'),
(7, 35, 4, 'Incredible sound quality but pricey.', '2024-03-15'),
(1, 38, 5, 'The iPhone camera is unmatched. Best upgrade ever!', '2024-02-20'),
(24, 40, 4, 'Great console but delivery took forever.', '2024-03-20');

-- =====================================================
-- END OF DATA
-- Database ready for analysis!
-- =====================================================

-- ==============================
-- Insert Sample Data
-- ==============================

-- Customers
INSERT INTO Customers (full_name, email, phone, is_prime) VALUES
('Ravi Kumar', 'ravi.kumar@example.com', '9876543210', TRUE),
('Ananya Sharma', 'ananya.sharma@example.com', '9876500001', FALSE),
('Vikram Singh', 'vikram.singh@example.com', '9876500002', FALSE),
('Meera Nair', 'meera.nair@example.com', '9876500003', TRUE),
('Arjun Patel', 'arjun.patel@example.com', '9876500004', FALSE),
('Sneha Reddy', 'sneha.reddy@example.com', '9876500005', FALSE),
('Karthik Rao', 'karthik.rao@example.com', '9876500006', TRUE),
('Divya Iyer', 'divya.iyer@example.com', '9876500007', FALSE),
('Rohan Mehta', 'rohan.mehta@example.com', '9876500008', FALSE),
('Priya Das', 'priya.das@example.com', '9876500009', TRUE);

-- Customer Addresses
INSERT INTO Customer_Addresses (customer_id, address_line1, city, state, pincode, is_default) VALUES
(1, '123 MG Road', 'Bengaluru', 'Karnataka', '560001', TRUE),
(1, '45 Residency Road', 'Bengaluru', 'Karnataka', '560025', FALSE),
(2, '12 Connaught Place', 'New Delhi', 'Delhi', '110001', TRUE),
(3, '9 Park Street', 'Kolkata', 'West Bengal', '700016', TRUE),
(4, '56 Anna Salai', 'Chennai', 'Tamil Nadu', '600002', TRUE),
(5, '78 CG Road', 'Ahmedabad', 'Gujarat', '380009', TRUE),
(6, '20 Jubilee Hills', 'Hyderabad', 'Telangana', '500033', TRUE),
(7, '10 Koregaon Park', 'Pune', 'Maharashtra', '411001', TRUE),
(8, '200 Marine Drive', 'Mumbai', 'Maharashtra', '400020', TRUE),
(9, '7 Sector 17', 'Chandigarh', 'Punjab', '160017', TRUE),
(10, '150 MG Marg', 'Lucknow', 'UP', '226001', TRUE);

-- Restaurants
INSERT INTO Restaurants (name, cuisine_type, city, address, open_time, close_time, avg_prep_time_min, rating_avg) VALUES
('Tandoori Tales', 'North Indian', 'Delhi', 'CP, New Delhi', '10:00', '23:00', 25, 4.3),
('Dosa Express', 'South Indian', 'Bengaluru', 'MG Road', '08:00', '22:00', 20, 4.5),
('Pizza Hub', 'Italian', 'Mumbai', 'Marine Drive', '11:00', '23:30', 30, 4.1),
('Dragon Wok', 'Chinese', 'Kolkata', 'Park Street', '12:00', '23:59', 35, 4.0),
('Burger Junction', 'Fast Food', 'Hyderabad', 'Banjara Hills', '10:00', '22:30', 15, 3.9),
('Healthy Bites', 'Vegan', 'Chennai', 'Anna Salai', '09:00', '21:00', 20, 4.6);

-- Menu Items
INSERT INTO Menu_Items (restaurant_id, item_name, category, price, diet_type) VALUES
(1, 'Paneer Butter Masala', 'Main Course', 220, 'veg'),
(1, 'Butter Naan', 'Bread', 40, 'veg'),
(2, 'Masala Dosa', 'Breakfast', 80, 'veg'),
(2, 'Idli Sambar', 'Breakfast', 60, 'veg'),
(3, 'Margherita Pizza', 'Pizza', 300, 'veg'),
(3, 'Pepperoni Pizza', 'Pizza', 400, 'nonveg'),
(4, 'Veg Hakka Noodles', 'Noodles', 180, 'veg'),
(4, 'Chicken Manchurian', 'Main Course', 250, 'nonveg'),
(5, 'Veg Burger', 'Snacks', 120, 'veg'),
(5, 'Chicken Burger', 'Snacks', 150, 'nonveg'),
(6, 'Vegan Salad Bowl', 'Healthy', 200, 'vegan'),
(6, 'Quinoa Pulao', 'Healthy', 250, 'vegan');

-- Delivery Partners
INSERT INTO Delivery_Partners (full_name, phone, vehicle_type, rating_avg, city) VALUES
('Amit Verma', '9991110001', 'Bike', 4.2, 'Delhi'),
('Rakesh Yadav', '9991110002', 'Scooter', 4.5, 'Bengaluru'),
('Sunil Sharma', '9991110003', 'Bike', 4.0, 'Mumbai'),
('Deepak Singh', '9991110004', 'Car', 3.8, 'Kolkata'),
('Vijay Kumar', '9991110005', 'Bike', 4.3, 'Hyderabad');

-- Orders
INSERT INTO Orders (customer_id, restaurant_id, delivery_partner_id, delivery_address_id, order_status, order_time, total_amount, delivery_fee, packaging_fee, tax_amount)
VALUES
(1, 1, 1, 1, 'delivered', NOW() - INTERVAL '3 DAY', 300, 30, 10, 20),
(2, 2, 2, 3, 'delivered', NOW() - INTERVAL '2 DAY', 140, 20, 5, 15),
(3, 3, 3, 4, 'cancelled', NOW() - INTERVAL '1 DAY', 350, 25, 10, 15),
(4, 4, 4, 5, 'delivered', NOW() - INTERVAL '5 DAY', 430, 30, 15, 25),
(5, 5, 5, 6, 'delivered', NOW() - INTERVAL '7 DAY', 270, 20, 10, 15),
(6, 6, 2, 7, 'delivered', NOW() - INTERVAL '6 DAY', 450, 35, 20, 25),
(7, 1, 1, 8, 'ontheway', NOW(), 260, 25, 10, 15),
(8, 3, 3, 9, 'placed', NOW(), 500, 40, 15, 30);

-- Order Items
INSERT INTO Order_Items (order_id, item_id, quantity, unit_price) VALUES
(1, 1, 1, 220),
(1, 2, 2, 40),
(2, 3, 1, 80),
(2, 4, 1, 60),
(3, 5, 1, 300),
(3, 6, 1, 400),
(4, 7, 2, 180),
(4, 8, 1, 250),
(5, 9, 1, 120),
(5, 10, 1, 150),
(6, 11, 1, 200),
(6, 12, 1, 250);

-- Payments
INSERT INTO Payments (order_id, payment_method, payment_status, amount, txn_reference) VALUES
(1, 'upi', 'success', 300, 'TXN1001'),
(2, 'card', 'success', 140, 'TXN1002'),
(3, 'upi', 'failed', 350, 'TXN1003'),
(4, 'wallet', 'success', 430, 'TXN1004'),
(5, 'cod', 'success', 270, 'TXN1005'),
(6, 'card', 'success', 450, 'TXN1006'),
(7, 'upi', 'pending', 260, 'TXN1007'),
(8, 'card', 'success', 500, 'TXN1008');

-- Deliveries
INSERT INTO Deliveries (order_id, partner_id, pickup_time, dropoff_time, distance_km, delivery_status, tip_amount) VALUES
(1, 1, NOW() - INTERVAL '3 DAY 1 HOUR', NOW() - INTERVAL '3 DAY 50 MINUTE', 5.2, 'delivered', 20),
(2, 2, NOW() - INTERVAL '2 DAY 40 MINUTE', NOW() - INTERVAL '2 DAY 20 MINUTE', 3.0, 'delivered', 10),
(4, 4, NOW() - INTERVAL '5 DAY 1 HOUR', NOW() - INTERVAL '5 DAY 30 MINUTE', 7.5, 'delivered', 25),
(5, 5, NOW() - INTERVAL '7 DAY 50 MINUTE', NOW() - INTERVAL '7 DAY 30 MINUTE', 4.5, 'delivered', 15),
(6, 2, NOW() - INTERVAL '6 DAY 1 HOUR', NOW() - INTERVAL '6 DAY 40 MINUTE', 6.0, 'delivered', 30);

-- Ratings
INSERT INTO Ratings (order_id, customer_id, restaurant_id, partner_id, rating_type, rating_value, review_text) VALUES
(1, 1, 1, 1, 'restaurant', 5, 'Delicious food and fast delivery'),
(1, 1, 1, 1, 'delivery', 4, 'Partner was polite'),
(2, 2, 2, 2, 'restaurant', 4, 'Crispy dosa and tasty sambar'),
(4, 4, 4, 4, 'restaurant', 3, 'Food was okay but delivery late'),
(5, 5, 5, 5, 'delivery', 5, 'Very quick and professional'),
(6, 6, 6, 2, 'restaurant', 5, 'Loved the vegan food');

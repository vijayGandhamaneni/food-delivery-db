-- ==============================
-- Food Delivery Database Schema
-- ==============================

-- Drop tables if already exist (for re-runs)
DROP TABLE IF EXISTS Ratings, Deliveries, Payments, Order_Items, Orders,
    Menu_Items, Restaurants, Customer_Addresses, Delivery_Partners, Customers CASCADE;

-- ==============================
-- Customers
-- ==============================
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    signup_date DATE DEFAULT CURRENT_DATE,
    is_prime BOOLEAN DEFAULT FALSE
);

-- ==============================
-- Customer Addresses
-- ==============================
CREATE TABLE Customer_Addresses (
    address_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id) ON DELETE CASCADE,
    address_line1 VARCHAR(200) NOT NULL,
    address_line2 VARCHAR(200),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    is_default BOOLEAN DEFAULT FALSE
);

-- ==============================
-- Restaurants
-- ==============================
CREATE TABLE Restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    cuisine_type VARCHAR(50),
    city VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    open_time TIME,
    close_time TIME,
    avg_prep_time_min INT,
    rating_avg DECIMAL(2,1),
    is_active BOOLEAN DEFAULT TRUE
);

-- ==============================
-- Menu Items
-- ==============================
CREATE TABLE Menu_Items (
    item_id SERIAL PRIMARY KEY,
    restaurant_id INT REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    is_available BOOLEAN DEFAULT TRUE,
    diet_type VARCHAR(20) CHECK (diet_type IN ('veg','nonveg','vegan'))
);

-- ==============================
-- Delivery Partners
-- ==============================
CREATE TABLE Delivery_Partners (
    partner_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    vehicle_type VARCHAR(50),
    rating_avg DECIMAL(2,1),
    city VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE
);

-- ==============================
-- Orders
-- ==============================
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    restaurant_id INT REFERENCES Restaurants(restaurant_id),
    delivery_partner_id INT REFERENCES Delivery_Partners(partner_id),
    delivery_address_id INT REFERENCES Customer_Addresses(address_id),
    order_status VARCHAR(20) CHECK (order_status IN 
        ('placed','accepted','preparing','ontheway','delivered','cancelled','refunded')),
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accepted_time TIMESTAMP,
    dispatched_time TIMESTAMP,
    delivered_time TIMESTAMP,
    delivery_fee DECIMAL(10,2) DEFAULT 0,
    packaging_fee DECIMAL(10,2) DEFAULT 0,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL
);

-- ==============================
-- Order Items
-- ==============================
CREATE TABLE Order_Items (
    order_id INT REFERENCES Orders(order_id) ON DELETE CASCADE,
    item_id INT REFERENCES Menu_Items(item_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    line_total DECIMAL(10,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    PRIMARY KEY(order_id, item_id)
);

-- ==============================
-- Payments
-- ==============================
CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE REFERENCES Orders(order_id),
    payment_method VARCHAR(20) CHECK (payment_method IN ('upi','card','cod','wallet')),
    payment_status VARCHAR(20) CHECK (payment_status IN ('success','failed','refunded','pending')),
    amount DECIMAL(10,2) NOT NULL,
    txn_reference VARCHAR(64),
    payment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- Deliveries
-- ==============================
CREATE TABLE Deliveries (
    delivery_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE REFERENCES Orders(order_id),
    partner_id INT REFERENCES Delivery_Partners(partner_id),
    pickup_time TIMESTAMP,
    dropoff_time TIMESTAMP,
    distance_km DECIMAL(6,2),
    delivery_status VARCHAR(20) CHECK (delivery_status IN ('assigned','picked_up','delivered','cancelled')),
    tip_amount DECIMAL(10,2) DEFAULT 0
);

-- ==============================
-- Ratings
-- ==============================
CREATE TABLE Ratings (
    rating_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES Orders(order_id),
    customer_id INT REFERENCES Customers(customer_id),
    restaurant_id INT REFERENCES Restaurants(restaurant_id),
    partner_id INT REFERENCES Delivery_Partners(partner_id),
    rating_type VARCHAR(20) CHECK (rating_type IN ('restaurant','delivery')),
    rating_value INT CHECK (rating_value BETWEEN 1 AND 5),
    review_text TEXT,
    rating_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

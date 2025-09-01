-- ==========================================
-- Analytical Queries for Food Delivery DB
-- ==========================================

-- 1. Find top 5 customers by total spending
SELECT c.full_name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.full_name
ORDER BY total_spent DESC
LIMIT 5;

-- 2. Most popular menu items (by order count)
SELECT mi.item_name, COUNT(oi.item_id) AS times_ordered
FROM Menu_Items mi
JOIN Order_Items oi ON mi.item_id = oi.item_id
GROUP BY mi.item_name
ORDER BY times_ordered DESC
LIMIT 5;

-- 3. Average delivery time per city
SELECT r.city, AVG(EXTRACT(EPOCH FROM (d.dropoff_time - d.pickup_time)) / 60) AS avg_delivery_minutes
FROM Deliveries d
JOIN Orders o ON d.order_id = o.order_id
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id
WHERE d.delivery_status = 'delivered'
GROUP BY r.city;

-- 4. Restaurant with highest total revenue
SELECT r.name, SUM(o.total_amount) AS revenue
FROM Restaurants r
JOIN Orders o ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'delivered'
GROUP BY r.name
ORDER BY revenue DESC
LIMIT 1;

-- 5. Delivery partner with best average rating (min 3 ratings)
SELECT dp.full_name, AVG(rt.rating_value) AS avg_rating, COUNT(rt.rating_id) AS num_ratings
FROM Delivery_Partners dp
JOIN Ratings rt ON dp.partner_id = rt.partner_id
WHERE rt.rating_type = 'delivery'
GROUP BY dp.full_name
HAVING COUNT(rt.rating_id) >= 3
ORDER BY avg_rating DESC;

-- 6. Orders that were cancelled but still had a payment attempt
SELECT o.order_id, c.full_name, p.payment_status, p.amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Payments p ON o.order_id = p.order_id
WHERE o.order_status = 'cancelled';

-- 7. Monthly revenue trend
SELECT TO_CHAR(order_time, 'YYYY-MM') AS month, SUM(total_amount) AS monthly_revenue
FROM Orders
WHERE order_status = 'delivered'
GROUP BY TO_CHAR(order_time, 'YYYY-MM')
ORDER BY month;

-- 8. Prime vs Non-Prime customer order counts
SELECT c.is_prime, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.is_prime;

-- 9. Average order value per cuisine type
SELECT r.cuisine_type, AVG(o.total_amount) AS avg_order_value
FROM Orders o
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.order_status = 'delivered'
GROUP BY r.cuisine_type;

-- 10. Top 3 restaurants in each city by average rating
WITH ranked_restaurants AS (
    SELECT r.city, r.name, r.rating_avg,
           RANK() OVER (PARTITION BY r.city ORDER BY r.rating_avg DESC) AS rank_in_city
    FROM Restaurants r
)
SELECT city, name, rating_avg
FROM ranked_restaurants
WHERE rank_in_city <= 3;

-- 11. Find customers who never placed an order
SELECT c.full_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 12. Total tips earned by each delivery partner
SELECT dp.full_name, SUM(d.tip_amount) AS total_tips
FROM Delivery_Partners dp
JOIN Deliveries d ON dp.partner_id = d.partner_id
GROUP BY dp.full_name
ORDER BY total_tips DESC;

# 🍔 Food Delivery Database Project

## 📌 Project Overview
This project is a **Food Delivery Database System** that simulates how platforms like Swiggy or Zomato manage customers, restaurants, menu items, delivery partners, and orders. It demonstrates my ability to design a relational database, insert realistic sample data, and run advanced SQL queries for business insights.  

The project is built using **PostgreSQL** inside a **Docker container**, making it portable and easy to run anywhere.  

---

## 🛠️ Tech Stack
- PostgreSQL 15 (Database)
- Docker (Containerization)
- SQL (Schema, Data, Queries)

---

## 📂 Project Structure
food-delivery-db/
│-- schema.sql # Database schema (tables + relationships)
│-- sample_data.sql # Inserted sample data
│-- queries.sql # Analytical queries
│-- README.md # Documentation

---

## 🚀 How to Run the Project

First, pull the PostgreSQL image and run a container:  

```bash
docker pull postgres:15
docker run --name fooddb -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=fooddb -p 5432:5432 -d postgres:15

## copy the files and execute them:

docker cp schema.sql fooddb:/tmp/schema.sql
docker cp sample_data.sql fooddb:/tmp/sample_data.sql
docker cp queries.sql fooddb:/tmp/queries.sql

docker exec -it fooddb psql -U postgres -d fooddb -f /tmp/schema.sql
docker exec -it fooddb psql -U postgres -d fooddb -f /tmp/sample_data.sql
#You can confirm that the database is loaded by running:
docker exec -it fooddb psql -U postgres -d fooddb -c "SELECT COUNT(*) FROM customers;"
#Now execute all the analytical queries:
docker exec -it fooddb psql -U postgres -d fooddb -f /tmp/queries.sql

📊 Sample Outputs

Top 5 Customers by Spending

 full_name   | total_spent
-------------+-------------
 Sneha Reddy |      450.00
 Meera Nair  |      430.00
 Ravi Kumar  |      300.00
 Arjun Patel |      270.00
 Ananya Sharma |    140.00


Monthly Revenue Trend

 month   | monthly_revenue
---------+-----------------
 2025-08 |         1590.00


Prime vs Non-Prime Customers

 is_prime | total_orders
----------+--------------
 f        |            5
 t        |            3


Average Delivery Time per City

   city    | avg_delivery_minutes
-----------+----------------------
 Bengaluru | 20.00
 Chennai   | 20.00
 Delhi     | 10.00
 Hyderabad | 20.00
 Kolkata   | 30.00


Customers Who Never Placed an Order

  full_name
-------------
 Priya Das
 Rohan Mehta


Total Tips Earned by Each Partner

  full_name   | total_tips
--------------+------------
 Rakesh Yadav |      40.00
 Deepak Singh |      25.00
 Amit Verma   |      20.00
 Vijay Kumar  |      15.00

📈 Key Learnings

Built a normalized relational schema for a real-world scenario.

Inserted realistic test data for customers, restaurants, and orders.

Ran business-focused queries such as top customers, prime vs non-prime orders, monthly revenue, and tips earned by delivery partners.

Learned how to use Docker to set up PostgreSQL quickly.

👨‍💻 Author

Vijay kiran chowdary Gandhamaneni
📧 gvijaychowdary2244@gmail.com

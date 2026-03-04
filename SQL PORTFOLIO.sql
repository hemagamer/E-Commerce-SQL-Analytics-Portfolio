-- =====================================================
-- BEGINNER LEVEL QUERIES - PRODUCT CATALOG ANALYSIS
-- =====================================================


-- 1.1.1: Show all products sorted by price (highest first)
-- Useful for identifying premium vs budget products
SELECT * 
FROM products 
ORDER BY price DESC;

-- 1.1.2: Filter products by smartphone category
-- Quick lookup for mobile device inventory
SELECT * 
FROM products 
WHERE category = 'Smartphones';

-- 1.1.3: Find affordable products under $500
-- Great for budget-conscious customer segment
SELECT * 
FROM products 
WHERE price < 500 
ORDER BY price DESC;

-- 1.1.4: Show products released after 2022
-- Helps identify our newest inventory
SELECT * 
FROM products 
WHERE release_date > '2022-12-31';


-- =====================================================
-- BEGINNER LEVEL QUERIES - CUSTOMER INSIGHTS
-- =====================================================

-- 1.2.1: View all customer records
-- Basic customer data overview
SELECT * 
FROM customers;

-- 1.2.2: Identify VIP customers
-- These are our highest-value customer segment
SELECT * 
FROM customers 
WHERE customer_segment = 'VIP';

-- 1.2.3: Find customers who registered in 2023
-- Useful for annual cohort analysis
SELECT * 
FROM customers 
WHERE registration_date > '2023-01-01' 
ORDER BY registration_date DESC;

-- 1.2.4: Show all customers from Scranton
-- Good for regional marketing campaigns (also finds our Office characters!)
SELECT * 
FROM customers 
WHERE city = 'Scranton';

-- 1.2.5: Count customers by segment type
-- Gives us distribution across VIP, Regular, and New customers
SELECT 
    customer_segment,
    COUNT(customer_segment) AS 'number of customers'
FROM customers 
GROUP BY customer_segment;


-- =====================================================
-- BEGINNER LEVEL QUERIES - ORDER STATUS TRACKING
-- =====================================================

-- 1.3.1: Show all pending orders
-- Operations team uses this to prioritize fulfillment
SELECT * 
FROM orders 
WHERE order_status = 'Pending';

-- 1.3.2: Find cancelled orders with customer details
-- Important for understanding why customers cancel
-- Join lets us see who cancelled, not just order IDs
SELECT 
    customers.first_name,
    customers.last_name,
    orders.order_id,
    orders.order_date,
    orders.order_status 
FROM customers 
INNER JOIN orders ON customers.customer_id = orders.customer_id 
WHERE order_status = 'Cancelled';

-- 1.3.3: Get all January 2024 orders
-- Monthly reporting for Q1 performance review
SELECT * 
FROM orders 
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31';

-- 1.3.4: View orders by most recent first
-- Dashboard view for customer service team
SELECT * 
FROM orders 
ORDER BY order_date DESC;


-- =====================================================
-- INTERMEDIATE LEVEL QUERIES - SALES PERFORMANCE
-- =====================================================

-- 2.1.1: Calculate total revenue by month
-- This is critical for finance reporting and trend analysis
-- Note: We're accounting for discounts in the revenue calculation
SELECT 
    YEAR(o.order_date) AS order_year,
    MONTHNAME(o.order_date) AS order_month,
    SUM((oi.quantity * oi.unit_price) * (1 - oi.discount_percentage/100)) AS total_revenue
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
GROUP BY order_year, order_month
-- Sort by most recent months first
ORDER BY order_year DESC, MONTH(MIN(o.order_date)) DESC;


-- 2.1.2: Find top 5 best-selling products by quantity
-- Product team needs this to understand what's flying off the shelves
-- Using product_id in GROUP BY to avoid issues with duplicate names
SELECT 
    products.product_name,
    SUM(order_items.quantity) AS total_quantity
FROM products
INNER JOIN order_items 
    ON products.product_id = order_items.product_id
GROUP BY products.product_id, products.product_name
ORDER BY total_quantity DESC 
LIMIT 5;

-- Alternative version: Quantity by product ID only
-- Less readable but useful for checking the logic
SELECT 
    order_items.product_id,
    SUM(order_items.quantity) 
FROM products
INNER JOIN order_items ON products.product_id = order_items.product_id
GROUP BY product_id;


-- 2.1.3: Calculate revenue by product category
-- Shows which categories are driving our business
-- This helps with inventory purchasing decisions
SELECT 
    products.category,
    SUM((order_items.quantity * order_items.unit_price) * (1 - order_items.discount_percentage/100)) AS total_revenue 
FROM order_items 
INNER JOIN products ON order_items.product_id = products.product_id 
GROUP BY category 
ORDER BY total_revenue DESC;


-- 2.1.4: Calculate Average Order Value (AOV)
-- Key metric for marketing to understand customer spending patterns
-- Using a subquery to first calculate each order's total, then average them
SELECT 
    AVG(order_total) AS AOV 
FROM (
    SELECT 
        order_id,
        SUM((quantity * unit_price) * (1 - order_items.discount_percentage/100)) AS order_total
    FROM order_items 
    GROUP BY order_id
) t1;


-- 2.1.5: Find products that have never been ordered
-- Helps identify dead stock or new products that need marketing push
-- LEFT JOIN keeps all products, IS NULL finds the ones without any orders
SELECT * 
FROM products p 
LEFT JOIN order_items oi ON p.product_id = oi.product_id 
WHERE oi.product_id IS NULL;

-- 2.2.1 Find customers who made 2+ purchases
select customer_id,count(*) as num from orders group by customer_id order by num desc;



select customers.customer_id,customers.first_name, customers.last_name,count(*) as num 
from orders inner join customers on orders.customer_id=customers.customer_id 
group by customer_id
having num>=2 
order by num desc ;

-- 2.2.2  Calculate average order value per customer segment (VIP vs Regular vs New)
select * from customers;
SELECT * FROM ORDER_ITEMS;
select customers.customer_id,customers.customer_segment from customers;
select count(*) from orders ;


SELECT C.CUSTOMER_SEGMENT,AVG(((OI.quantity * OI.unit_price) * (1 - OI.discount_percentage/100))) AS AOV
FROM CUSTOMERS C
JOIN ORDERS O ON C.CUSTOMER_ID =O.CUSTOMER_ID
JOIN order_items OI ON OI.ORDER_ID=O.ORDER_ID
group by C.CUSTOMER_SEGMENT;


-- 2.2.3: Show customer lifetime value (total spent per customer)

select c.customer_id from customers c join orders o on o.customer_id = c.customer_id;

SELECT order_id,SUM((quantity * unit_price) * (1 - order_items.discount_percentage/100)) AS order_total FROM order_items group by order_id;


SELECT c.customer_id ,SUM((quantity * unit_price) * (1 - order_items.discount_percentage/100)) AS Total_spent FROM customers c
join orders o on c.customer_id=o.customer_id
join order_items on o.order_id=order_items.order_id 
group by c.customer_id
order by total_spent desc ;

select * from customers where customer_id=22;

-- 2.2.4: Identify registered customers with no orders yet
select * from order_items ;

SELECT c.customer_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- 2.2.5: Find the most active shopping day of the week
select dayname(order_date),
count(*) as num_ord
from orders 
group by dayname(order_date)
order by num_ord desc
limit 1 ;

-- 2.3.1: Show products with average rating above 4.5

select product_id,avg(rating) as AV from reviews group by product_id having AV>4.5 ;


-- 2.3.2: List products reviewed but never purchased (or vice versa)
SELECT DISTINCT oi.product_id
FROM order_items oi
LEFT JOIN reviews r
ON r.product_id = oi.product_id
WHERE r.product_id IS NULL

union

select distinct r.product_id
from reviews r
left join order_items oi
on oi.product_id=r.product_id
where oi.product_id is null;

-- 2.3.3: Calculate average rating per product category
select p.category,avg(r.rating) from products p 
inner join reviews r on p.product_id=r.product_id
group by p.category;


-- 2.3.4: Find products with stock below 100 units
select * from products p where stock_quantity <100;

-- 2.3.5: Show profit margin by product (price - cost)
select Product_name,(price-cost) as margin from products order by margin desc ;

-- 2.4.1: Calculate average time from order to delivery
select delivery_date,order_date from orders;
SELECT AVG(TIMESTAMPDIFF(HOUR, order_date, delivery_date)) AS avg_hours_to_deliver 
FROM orders;

-- 2.4.2: Find orders that took longer than 4 days to deliver
SELECT order_id,
       TIMESTAMPDIFF(DAY, order_date, delivery_date) AS days_to_deliver
FROM orders
WHERE TIMESTAMPDIFF(DAY, order_date, delivery_date) > 4;

-- 2.4.3: Show delivery performance by month
SELECT 
    YEAR(delivery_date) AS year,
    MONTH(delivery_date) AS month,
    COUNT(*) AS num_deliveries
FROM orders
GROUP BY YEAR(delivery_date), MONTH(delivery_date)
ORDER BY YEAR(delivery_date), MONTH(delivery_date);


-- 2.4.4: Calculate cancellation rate
select * from orders;
select count(*) as cancelled,(count(*)/(select count(*) from orders))*100 as cancel_rate from orders where order_status like 'c%';

-- 2.4.5: Identify orders still pending 
select * from orders where order_status like 'P%';


-- 3.1.1: Perform RFM analysis (Recency, Frequency, Monetary value)
SELECT 
    o.customer_id,
    -- Recency (relative to dataset max date)
    DATEDIFF((SELECT MAX(order_date) FROM orders),MAX(o.order_date)) AS recency,
    -- Frequency
    COUNT(DISTINCT o.order_id) AS frequency,
    -- Monetary
    SUM((oi.quantity * oi.unit_price) * (1 - oi.discount_percentage / 100)) AS monetary
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY o.customer_id
ORDER BY recency ASC, frequency DESC, monetary DESC;


-- 3.1.2: Identify top 20% customers by revenue Pareto principle

WITH customer_revenue AS (
    SELECT 
        o.customer_id,
        SUM((oi.quantity * oi.unit_price) * 
            (1 - oi.discount_percentage / 100)
        ) AS revenue
    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.customer_id
)

SELECT *
FROM (
    SELECT *,
           NTILE(5) OVER (ORDER BY revenue DESC) AS revenue_group
    FROM customer_revenue
) ranked
WHERE revenue_group = 1;


-- 3.1.3: Find customers who purchased in Q1 2024 but not Q2
select 
distinct customer_id from orders o
where o.delivery_date between '2024-01-01' and '2024-03-31' 
and o.customer_id not in(select customer_id from orders where delivery_date >='2024-04-01'and delivery_date<'2024-07-01');

-- 3.1.4: Calculate customer churn rate (no orders in 90+ days)
WITH maxz AS (
    SELECT customer_id,
           MAX(delivery_date) AS last_order
    FROM orders
    GROUP BY customer_id
),
max_date AS (
    SELECT MAX(delivery_date) AS last_date
    FROM orders
),
churned AS (
    SELECT m.customer_id
    FROM maxz m
    CROSS JOIN max_date d
    WHERE DATEDIFF(d.last_date, m.last_order) > 90
)
SELECT 
    COUNT(*) AS churned_customers,
    COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT customer_id) FROM orders) AS churn_rate_percent
FROM churned;


-- 3.1.5: Segment customers by average order value
select AVG(order_total) as AOV from (
select order_id,sum((oi.unit_price*oi.quantity)*(1-oi.discount_percentage/100)) as order_total
from order_items oi
group by order_id
)t1;

with customer_aov as (
select o.customer_id,
sum((oi.unit_price*oi.quantity)*(1-oi.discount_percentage/100)) as order_total,
count(distinct o.order_id) as num_orders,
sum((oi.unit_price*oi.quantity)*(1-oi.discount_percentage/100))/count(distinct o.order_id) as aov
from order_items oi
join orders o on o.order_id=oi.order_id
group by customer_id

)

select 
	customer_id,
    aov,
	case 
		when aov<50 then 'low'
		when aov between 50 and 150 then 'meduim'
		else 'high'
	end as segment
from customer_aov;



-- 3.2.1: Find products with decreasing sales trends month-over-month
   
with monthly_sales as (select oi.product_id,sum(oi.quantity*oi.unit_price*(1-oi.discount_percentage/100)) as sales,year(o.order_date) as yr ,month(o.order_date) as mon 
from order_items oi 
join orders o on o.order_id=oi.order_id 
group by oi.product_id,year(o.order_date),month(o.order_date) order by product_id asc)

select * , 
	case
		when sales < lag(sales) over (partition by product_id order by yr,mon)
			then 'decreasing'
		when sales > lag(sales) over (partition by product_id order by yr,mon)
			then 'increasing'
		else 'stable'
	end as trend	
from monthly_sales;

-- 3.2.2: Calculate inventory turnover rate by product
-- select * from products;
select p.product_id,p.product_name ,sum(oi.quantity*oi.unit_price)/p.stock_quantity as inv 
from order_items oi 
join products p on oi.product_id=p.product_id
group by p.product_id,p.product_name,p.stock_quantity
order by inv desc;

-- 3.2.3: Identify slow-moving inventory (low sales but high stock)

select p.product_name,p.product_id,p.stock_quantity,count(*) as times_sold from order_items oi join products p on p.product_id=oi.product_id group by product_id,p.product_name,p.stock_quantity
having times_sold<5 and p.stock_quantity >50
order by count(*) asc;

-- 3.2.4: Show products frequently bought together (market basket basics)
select oi1.product_id as product_1,
oi2.product_id as product_2,
count(*) as item_bought_together 
from order_items oi1
join order_items oi2
	on oi1.order_id=oi2.order_id
	and oi1.product_id<oi2.product_id
group by oi1.product_id,oi2.product_id
order by item_bought_together desc 
limit 20;


-- 3.2.5: Calculate stock-to-sales ratio

select p.product_id ,p.product_name,p.stock_quantity,sum(oi.quantity) as unitssold,
p.stock_quantity/sum(oi.quantity) as stockstosales from order_items oi join products p on p.product_id=oi.product_id
group by p.product_id ,p.product_name,p.stock_quantity 
order by stockstosales desc ;


-- 3.3.1: Create monthly customer cohorts based on registration date

select date_format(registration_date,'%y-%m') as cohort_month,count(*) as num_customers 
from customers

group by date_format(registration_date,'%y-%m')
order by date_format(registration_date,'%y-%m') ;

-- 3.3.2: Calculate retention rate by cohort

WITH cohort_base AS (
    SELECT 
        customer_id,
        DATE_FORMAT(registration_date, '%y-%m') AS cohort_month
    FROM customers
),

cohort_activity AS (
    SELECT 
        cb.cohort_month,
        DATE_FORMAT(o.order_date, '%y-%m') AS activity_month,
        COUNT(DISTINCT cb.customer_id) AS active_customers
    FROM cohort_base cb
    JOIN orders o 
        ON cb.customer_id = o.customer_id
    GROUP BY cb.cohort_month, activity_month
),

cohort_size AS (
    SELECT 
        DATE_FORMAT(registration_date, '%y-%m') AS cohort_month,
        COUNT(*) AS total_customers
    FROM customers
    GROUP BY cohort_month
)

SELECT 
    ca.cohort_month,
    ca.activity_month,
    ca.active_customers,
    cs.total_customers,
    (ca.active_customers * 100.0) / cs.total_customers AS retention_rate
FROM cohort_activity ca
JOIN cohort_size cs 
    ON ca.cohort_month = cs.cohort_month
ORDER BY ca.cohort_month, ca.activity_month;

-- 3.3.3: Show revenue contribution by cohort over time


SELECT
    DATE_FORMAT(c.registration_date, '%y-%m') AS cohort_month,
    DATE_FORMAT(o.order_date, '%y-%m') AS activity_month,
    SUM((oi.unit_price * oi.quantity) * 
        (1 - oi.discount_percentage/100)) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;

-- 3.3.4: Analyze new vs returning customer purchases
WITH first_orders AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
)

SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    CASE 
        WHEN o.order_date = f.first_order_date THEN 'New'
        ELSE 'Returning'
    END AS customer_type
FROM orders o
JOIN first_orders f 
    ON o.customer_id = f.customer_id;
    
-- 3.4.1: Calculate running total revenue by day
SELECT
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY order_date) AS running_total
FROM (
    SELECT 
        DATE(o.order_date) AS order_date,
        SUM((oi.unit_price * oi.quantity) * 
            (1 - oi.discount_percentage/100)) AS daily_revenue
    FROM order_items oi
    JOIN orders o 
        ON oi.order_id = o.order_id
    GROUP BY DATE(o.order_date)
) t
ORDER BY order_date;
-- 3.4.2: Show year-over-year growth rate by month
SELECT
    curr.year_month_of_order,
    curr.total_revenue,
    prev.total_revenue AS prev_year_revenue,
    ((curr.total_revenue - prev.total_revenue) / prev.total_revenue) * 100 AS yoy_growth_pct
FROM
    (SELECT 
        DATE_FORMAT(o.order_date, '%y-%m') AS year_month_of_order,
        YEAR(o.order_date) AS year,
        MONTH(o.order_date) AS month,
        SUM((oi.unit_price * oi.quantity) * (1 - oi.discount_percentage)) AS total_revenue
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    GROUP BY year, month, year_month_of_order
    ) curr
LEFT JOIN
    (SELECT 
        YEAR(o.order_date) AS year,
        MONTH(o.order_date) AS month,
        SUM((oi.unit_price * oi.quantity) * (1 - oi.discount_percentage)) AS total_revenue
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    GROUP BY year, month
    ) prev
ON curr.month = prev.month AND curr.year = prev.year + 1
ORDER BY curr.year, curr.month;



-- 3.4.3: Calculate revenue per customer acquisition by month
select count( distinct c.customer_id) as customers_acquired,date_format(registration_date,'%y-%m') as acquisition_month,SUM((oi.unit_price * oi.quantity) * (1 - oi.discount_percentage/100)) as revenue,SUM((oi.unit_price * oi.quantity) * (1 - oi.discount_percentage/100))/count(distinct c.customer_id) as rev_per_customer from customers c join orders o on o.customer_id=c.customer_id
join order_items oi on oi.order_id=o.order_id
group by date_format(registration_date,'%y-%m')
order by date_format(registration_date,'%y-%m');

-- 3.4.4: Find seasonal trends in sales
select p.category,
	CASE 
        WHEN MONTH(o.delivery_date) IN (12,1,2) THEN 'Winter'
        WHEN MONTH(o.delivery_date) IN (3,4,5) THEN 'Spring'
        WHEN MONTH(o.delivery_date) IN (6,7,8) THEN 'Summer'
        ELSE 'Fall'
    END AS season,
SUM((oi.unit_price * oi.quantity) * (1 - oi.discount_percentage/100)) as total_sales,year(o.delivery_date)
from order_items oi
join orders o on o.order_id=oi.order_id
join products p on oi.product_id=p.product_id
group by p.category,season,year(o.delivery_date)
order by p.category,season,year(o.delivery_date);

-- 3.4.5: Show contribution of each category to total revenue

SELECT
    p.category,
    SUM((oi.unit_price * oi.quantity) *
        (1 - oi.discount_percentage/100)) AS category_revenue,
    SUM((oi.unit_price * oi.quantity) *
        (1 - oi.discount_percentage/100)) 
    / 
    (SELECT SUM((unit_price * quantity) *
            (1 - discount_percentage/100))
     FROM order_items) * 100 AS contribution_pct
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY contribution_pct DESC;
-- 3.5.1: Which customers are at risk of churning?
WITH maxdate AS (
    SELECT MAX(order_date) AS dataset_max_date
    FROM orders
)

SELECT 
    o.customer_id,
    MAX(o.order_date) AS last_order_date,
    m.dataset_max_date,
    DATEDIFF(m.dataset_max_date, MAX(o.order_date)) AS inactivity_days,
    CASE 
        WHEN DATEDIFF(m.dataset_max_date, MAX(o.order_date)) > 90 THEN 'churned'
        WHEN DATEDIFF(m.dataset_max_date, MAX(o.order_date)) > 60 THEN 'at risk'
        ELSE 'active'
    END AS customer_status
FROM orders o
CROSS JOIN maxdate m
GROUP BY o.customer_id, m.dataset_max_date;






-- 3.5.2: What's the optimal discount percentage for each category?
SELECT category, discount_percentage, total_revenue
FROM (
    SELECT
        p.category,
        oi.discount_percentage,
        SUM((oi.unit_price * oi.quantity) *
            (1 - oi.discount_percentage/100)) AS total_revenue,
        RANK() OVER (
            PARTITION BY p.category
            ORDER BY SUM((oi.unit_price * oi.quantity) *
                (1 - oi.discount_percentage/100)) DESC
        ) AS rnk
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY p.category, oi.discount_percentage
) t
WHERE rnk = 1;

-- 3.5.3: Which products should be bundled based on purchase patterns?
select oi1.product_id as id1,oi2.product_id as id2,count(*) as frequency from order_items oi1 
join order_items oi2 on oi1.order_id=oi2.order_id 
where oi1.product_id < oi2.product_id
group by oi1.product_id,oi2.product_id
order by frequency desc ;
-- 3.5.4: Calculate customer acquisition cost efficiency by payment method
select * from customers;
select  count(distinct o.customer_id) as total_customer,SUM((oi.unit_price * oi.quantity) *
            (1 - oi.discount_percentage/100)) AS total_revenue,o.payment_method,SUM((oi.unit_price * oi.quantity) *
            (1 - oi.discount_percentage/100))/count(distinct customer_id) as revenue_per_customer from order_items oi join orders o 
            on o.order_id=oi.order_id group by payment_method  ;
            

-- 3.5.5: Identify power users (top 10% by order frequency and value)
WITH customer_stats AS (
    SELECT 
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(oi.quantity * oi.unit_price * 
            (1 - oi.discount_percentage / 100)) AS total_revenue
    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
),

ranked_customers AS (
    SELECT 
        customer_id,
        order_count,
        total_revenue,
        NTILE(10) OVER (ORDER BY order_count DESC) AS freq_rank,
        NTILE(10) OVER (ORDER BY total_revenue DESC) AS value_rank
    FROM customer_stats
)

SELECT 
    customer_id,
    order_count,
    total_revenue
FROM ranked_customers
WHERE freq_rank = 1
  AND value_rank = 1
ORDER BY total_revenue DESC;


-- 4.1.1  Probability of Repeat Purchase by Customer Segment
WITH customer_orders AS (
    SELECT 
        c.customer_id,
        c.customer_segment,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_segment
)

SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) * 1.0 
        / COUNT(*), 
        3
    ) AS repeat_purchase_probability
FROM customer_orders
GROUP BY customer_segment;

-- 4.1.2: Build a product recommendation query (if customer bought X, they might like Y)

SELECT 
    p1.product_name AS product_X,
    p2.product_name AS product_Y,
    COUNT(*) AS bought_together_count
FROM order_items oi1
JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id
JOIN products p1
    ON oi1.product_id = p1.product_id
JOIN products p2
    ON oi2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
ORDER BY p1.product_name, bought_together_count DESC;


-- 4.1.3: Identify products that drive customer retention

SELECT p.product_name,
       COUNT(DISTINCT o.customer_id) AS num_returning_customers
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
)
GROUP BY p.product_id, p.product_name
ORDER BY num_returning_customers DESC;

-- 4.1.4: Calculate customer lifetime value prediction based on first purchase
WITH customer_orders AS (
    SELECT 
        o.customer_id,
        MIN(o.order_date) AS first_order_date,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM((oi.unit_price * oi.quantity) * (1 - oi.discount_percentage/100)) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)

SELECT 
    co.customer_id,
    co.first_order_date,
    co.total_orders,
    co.total_revenue,
    co.total_revenue / co.total_orders AS avg_order_value,
    (co.total_revenue / co.total_orders) * co.total_orders * 1.2 AS predicted_lifetime_value
FROM customer_orders co;


-- 4.1.5: Segment products by growth trajectory
WITH monthly_sales AS (
    SELECT
        oi.product_id,
        p.product_name,
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM((oi.unit_price * oi.quantity) * (1 - oi.discount_percentage/100)) AS revenue
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY oi.product_id, p.product_name, month
),
sales_with_prev AS (
    SELECT 
        m.*,
        LAG(revenue) OVER (PARTITION BY product_id ORDER BY month) AS prev_month_revenue
    FROM monthly_sales m
),
product_growth AS (
    SELECT
        product_id,
        product_name,
        AVG(
            CASE
                WHEN prev_month_revenue IS NULL THEN 0
                ELSE (revenue - prev_month_revenue) / prev_month_revenue * 100
            END
        ) AS avg_growth_pct
    FROM sales_with_prev
    GROUP BY product_id, product_name
)
SELECT
    product_id,
    product_name,
    avg_growth_pct,
    CASE
        WHEN avg_growth_pct > 0 THEN 'Growing'
        WHEN avg_growth_pct = 0 THEN 'Stagnant'
        ELSE 'Declining'
    END AS growth_segment
FROM product_growth
ORDER BY avg_growth_pct DESC;

-- 4.2.1 Create a comprehensive sales dashboard query (multiple metrics in one)
SELECT
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN cust_orders.orders_count > 1 THEN o.customer_id END) AS repeat_customers
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN (
    SELECT customer_id, COUNT(*) AS orders_count
    FROM orders
    GROUP BY customer_id
) cust_orders ON o.customer_id = cust_orders.customer_id;



SELECT
    p.category,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;



SELECT
    p.product_name,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- 4.2.2: Build a customer health score using multiple factors

WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        MAX(o.order_date) AS last_order_date,                 -- for recency
        COUNT(DISTINCT o.order_id) AS frequency,             -- number of orders
        SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS monetary, -- total spend
        AVG(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS avg_order_value,
        CASE WHEN COUNT(DISTINCT o.order_id) > 1 THEN 1 ELSE 0 END AS repeat_customer -- repeat flag
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id
),
normalized AS (
    SELECT
        customer_id,
        -- Recency: more recent purchases get higher score
        100 - DATEDIFF(CURDATE(), last_order_date) AS recency_score,
        -- Frequency normalized to max
        frequency / MAX(frequency) OVER () * 100 AS frequency_score,
        -- Monetary normalized to max
        monetary / MAX(monetary) OVER () * 100 AS monetary_score,
        -- Average Order Value normalized to max
        avg_order_value / MAX(avg_order_value) OVER () * 100 AS aov_score,
        repeat_customer * 100 AS repeat_score -- binary factor scaled
    FROM customer_metrics
)
SELECT
    customer_id,
    ROUND(
        0.25 * recency_score +
        0.25 * frequency_score +
        0.25 * monetary_score +
        0.15 * aov_score +
        0.10 * repeat_score, 2
    ) AS health_score
FROM normalized
ORDER BY health_score DESC;

-- 4.2.3: Analyze correlation between product ratings and sales volume
-- Product ratings and sales volume
SELECT
    p.product_id,
    p.product_name,
    AVG(r.rating) AS avg_rating,
    SUM(oi.quantity) AS total_sales_volume
FROM products p
LEFT JOIN reviews r ON p.product_id = r.product_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales_volume DESC;


-- 4.2.4: Calculate time-to-first-repeat-purchase by product category

WITH customer_orders AS (
    SELECT 
        o.customer_id,
        oi.product_id,
        p.category, 
        o.order_id,
        o.order_date
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
),

ranked_orders AS (
    SELECT
        customer_id,
        category,  
        order_id,
        order_date,
        
        ROW_NUMBER() OVER (PARTITION BY customer_id, category ORDER BY order_date) AS order_rank
    FROM customer_orders
)

SELECT
    first_order.category, -- FIX 4: Explicitly reference the 'first_order' alias
    AVG(DATEDIFF(second_order.order_date, first_order.order_date)) AS avg_time_to_repeat_days
    
 
FROM
    ranked_orders first_order
JOIN
    ranked_orders second_order
    ON first_order.customer_id = second_order.customer_id
    AND first_order.category = second_order.category 
    AND first_order.order_rank = 1
    AND second_order.order_rank = 2
GROUP BY first_order.category
ORDER BY avg_time_to_repeat_days;


-- 4.2.5: Identify cross-sell opportunities based on historical data
WITH product_pairs AS (
    SELECT
        oi1.product_id AS product_a,
        oi2.product_id AS product_b,
        COUNT(*) AS times_bought_together
    FROM order_items oi1
    JOIN order_items oi2 
        ON oi1.order_id = oi2.order_id
        AND oi1.product_id < oi2.product_id   -- avoids duplicate/reverse pairs
    GROUP BY oi1.product_id, oi2.product_id
)

SELECT 
    pp.product_a,
    pa.product_name AS product_a_name,
    pp.product_b,
    pb.product_name AS product_b_name,
    pp.times_bought_together
FROM product_pairs pp
JOIN products pa ON pp.product_a = pa.product_id
JOIN products pb ON pp.product_b = pb.product_id
ORDER BY pp.times_bought_together DESC
LIMIT 50;


-- 5.1.1: Which Dunder Mifflin employees are the biggest spenders?

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS employee_name,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
where c.email like '%dunder%'

GROUP BY c.customer_id, employee_name
ORDER BY total_spent DESC
LIMIT 10;  -- top 10 spenders

-- 5.1.2: What's the total revenue from Scranton-based customers?
SELECT 
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE c.city LIKE 'Scranton';

-- 5.1.3: How many World's Best Boss Mugs has Michael Scott ordered?
SELECT 
    SUM(oi.quantity) AS total_mugs_ordered
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
WHERE p.product_name LIKE '%World''s Best Boss Mug%'  
  AND c.first_name = 'Michael' 
  AND c.last_name = 'Scott';
  
  -- 5.1.4: Calculate profit margin on Dunder Mifflin branded products vs tech products
  SELECT 
    CASE 
        WHEN p.brand LIKE 'Dunder%' THEN 'Dunder Mifflin'
        WHEN p.category LIKE '%Tech%' THEN 'Tech'
        ELSE 'Other'
    END AS product_group,
    SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS total_revenue,
    SUM(p.cost * oi.quantity) AS total_cost,
    ROUND(
        (SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) - SUM(p.cost * oi.quantity))
        / SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) * 100,
        2
    ) AS profit_margin_pct
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
WHERE p.brand LIKE 'Dunder%' OR p.category LIKE '%Tech%'
GROUP BY product_group;

-- 5.1.5: Find all customers who ordered Office-themed products
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.product_name LIKE '%Office%';

-- 5.1.6: Which Office character has the highest customer lifetime value?
SELECT CONCAT(c.first_name, ' ', c.last_name) AS character_name,
       SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE c.email LIKE 'dunder%'  -- assuming Dunder Mifflin employees = Office characters
GROUP BY c.customer_id
ORDER BY lifetime_value DESC
LIMIT 1;

-- 5.1.7: Do people who buy Dundies also buy Boss Mugs?
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.customer_id IN (
    SELECT c.customer_id
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.product_name LIKE '%Dundies%'
)
AND p.product_name LIKE '%Boss Mug%';

-- 5.2.1: Total orders shipped to Scranton addresses
SELECT COUNT(*) AS total_orders
FROM orders
WHERE shipping_address LIKE '%Scranton%';

-- 5.2.2: Compare Scranton customer segment distribution vs other cities
SELECT 
    CASE WHEN city LIKE '%Scranton%' THEN 'Scranton' ELSE 'Other' END AS location_group,
    customer_segment,
    COUNT(*) AS customer_count
FROM customers
GROUP BY location_group, customer_segment;

-- 5.2.3: Average order value for Scranton customers vs non-Scranton
SELECT 
    CASE WHEN c.city LIKE '%Scranton%' THEN 'Scranton' ELSE 'Non-Scranton' END AS location_group,
    AVG(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY location_group;

-- 5.2.4: Identify the most popular products in Scranton
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.city LIKE '%Scranton%'
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
LIMIT 10;


-- 5.3.1: Did Dwight really buy 50 beet seeds?
SELECT o.order_id, SUM(oi.quantity) AS total_quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE CONCAT(c.first_name, ' ', c.last_name) = 'Dwight Schrute'
  AND p.product_name LIKE '%Beet Seeds%'
GROUP BY o.order_id;

-- 5.3.2: How many pranks has Jim ordered? (Stapler in Jello Kits)
SELECT SUM(oi.quantity) AS total_pranks
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE CONCAT(c.first_name, ' ', c.last_name) = 'Jim Halpert'
  AND p.product_name LIKE '%Stapler in Jello%';
  
-- 5.3.3: What's Stanley's purchase history? (Pretzel-related)
SELECT o.order_id, p.product_name, oi.quantity, oi.unit_price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE CONCAT(c.first_name, ' ', c.last_name) = 'Stanley Hudson'
  AND p.product_name LIKE '%Pretzel%';
  
-- 5.3.4: Find all orders containing The Office themed products
SELECT DISTINCT o.order_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.product_name LIKE '%Office%';

-- 5.3.5: Which character left a 1-star review?
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, r.product_id, r.rating, r.review_text
FROM reviews r
JOIN customers c ON r.customer_id = c.customer_id
WHERE r.rating = 1;

-- 5.4.1: Best selling Dunder Mifflin products by quantity
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
WHERE p.brand LIKE 'Dunder%'
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
LIMIT 10;

-- 5.4.2: Average rating of Office-themed products vs tech products
SELECT 
    CASE 
        WHEN p.product_name LIKE '%Office%' THEN 'Office'
        WHEN p.category LIKE '%Tech%' THEN 'Tech'
    END AS product_group,
    AVG(r.rating) AS avg_rating
FROM products p
JOIN reviews r ON p.product_id = r.product_id
WHERE p.product_name LIKE '%Office%' OR p.category LIKE '%Tech%'
GROUP BY product_group;
-- 5.4.3: Inventory turnover for novelty items vs electronics
SELECT 
    CASE 
        WHEN p.category LIKE '%Novelty%' THEN 'Novelty'
        WHEN p.category LIKE '%Electronics%' THEN 'Electronics'
    END AS category_group,
    SUM(oi.quantity) / SUM(p.stock_quantity) AS inventory_turnover
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
WHERE p.category LIKE '%Novelty%' OR p.category LIKE '%Electronics%'
GROUP BY category_group;

-- 5.4.4: Revenue generated from "Office Pranks" category
SELECT SUM(oi.unit_price * oi.quantity * (1 - oi.discount_percentage/100)) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
WHERE p.category = 'Office Pranks';
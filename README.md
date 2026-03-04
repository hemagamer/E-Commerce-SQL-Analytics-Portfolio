# 📊 E-Commerce SQL Analytics Portfolio

**A comprehensive SQL project demonstrating advanced data analysis techniques using a tech e-commerce database with a twist of humor from *The Office* TV series.**

---

## 🎯 Project Overview

This portfolio showcases **90+ SQL queries** spanning from fundamental data retrieval to advanced business intelligence, customer segmentation, and cohort analysis. The project uses a realistic e-commerce database containing:

- **100 customers** (including 25 characters from *The Office*)
- **60 products** (tech products + Office-themed novelty items)
- **300+ orders** spanning 2022-2024
- **Multiple tables** with proper relationships and constraints

**Why this project stands out:**
- ✅ Covers real-world business questions that analytics teams face daily
- ✅ Demonstrates technical SQL proficiency across all difficulty levels
- ✅ Shows business acumen through metric selection and interpretation
- ✅ Includes creative storytelling elements (Office characters) for memorability
- ✅ Production-ready queries with proper formatting and documentation

---

## 🗂️ Database Schema

```
┌─────────────┐      ┌──────────────┐      ┌─────────────┐
│  customers  │──┐   │    orders    │──┐   │  products   │
├─────────────┤  │   ├──────────────┤  │   ├─────────────┤
│customer_id  │  └──→│customer_id   │  │   │product_id   │
│first_name   │      │order_id      │  │   │product_name │
│last_name    │      │order_date    │  │   │category     │
│email        │      │order_status  │  │   │price        │
│city         │      │payment_method│  │   │stock_qty    │
│segment      │      └──────────────┘  │   └─────────────┘
│reg_date     │                        │          
└─────────────┘                        │          
                                       │   ┌─────────────┐
                ┌──────────────┐       └──→│order_items  │
                │   reviews    │           ├─────────────┤
                ├──────────────┤           │order_id     │
                │review_id     │           │product_id   │
                │product_id    │           │quantity     │
                │customer_id   │           │unit_price   │
                │rating        │           │discount_%   │
                │review_text   │           └─────────────┘
                └──────────────┘
```

---

## 📋 Query Categories & Skills Demonstrated

### **1️⃣ Beginner Level (17 queries)**
**Skills:** Basic SELECT, WHERE, ORDER BY, JOINs, GROUP BY, Aggregations

- Product catalog filtering and sorting
- Customer segmentation analysis
- Order status tracking and reporting

**Business Value:** Foundational queries for daily operational reporting

---

### **2️⃣ Intermediate Level (20 queries)**
**Skills:** Multi-table JOINs, Aggregations, Subqueries, Date functions, HAVING clause

#### Sales Performance (5 queries)
- Monthly revenue calculation with discount logic
- Top-selling products analysis
- Category-level revenue breakdown
- Average order value (AOV) metrics
- Dead stock identification

#### Customer Behavior (5 queries)
- Repeat purchase identification
- Segment-based AOV comparison
- Customer lifetime value (LTV) calculation
- Inactive customer detection
- Shopping pattern analysis (day-of-week trends)

#### Product Performance (5 queries)
- Rating-based product filtering
- Review vs. purchase correlation analysis
- Category-level quality metrics
- Low-stock alerts
- Profit margin analysis

#### Fulfillment & Operations (5 queries)
- Delivery time analysis (order-to-door metrics)
- SLA breach identification
- Monthly fulfillment performance
- Cancellation rate calculation
- Pending order monitoring

**Business Value:** Core analytics for operations, marketing, and product teams

---

### **3️⃣ Advanced Level (25 queries)**
**Skills:** Window functions, CTEs, Complex subqueries, Self-joins, Advanced aggregations

#### Customer Segmentation & RFM Analysis (5 queries)
- **RFM Segmentation:** Recency, Frequency, Monetary value analysis
- **Pareto Analysis:** 80/20 rule - Top 20% revenue contributors
- **Quarterly retention:** Q1 vs Q2 purchase behavior
- **Churn identification:** 90-day inactivity flagging
- **AOV segmentation:** Grouping by spending patterns

#### Inventory & Product Movement (5 queries)
- Month-over-month sales trend detection
- Inventory turnover rate calculation
- Slow-moving inventory alerts
- Market basket analysis (frequently bought together)
- Stock-to-sales ratio optimization

#### Cohort & Retention Analysis (4 queries)
- Monthly registration cohorts
- Retention rate by cohort
- Revenue contribution trends by cohort
- New vs. returning customer behavior

#### Time Series & Trend Analysis (5 queries)
- Running total revenue (cumulative metrics)
- Year-over-year growth rates
- Customer acquisition cost analysis
- Seasonal trend identification
- Category contribution over time

#### Strategic Business Questions (6 queries)
- At-risk customer identification
- Discount optimization analysis
- Product bundling opportunities
- Payment method efficiency
- Power user identification (top 10%)

**Business Value:** Strategic insights for executive decision-making and forecasting

---

### **4️⃣ Expert Level (10 queries)**
**Skills:** Predictive metrics, Multi-metric dashboards, Complex scoring systems

#### Predictive Modeling (5 queries)
- Repeat purchase probability by segment
- Product recommendation engine (collaborative filtering basics)
- Retention-driving product identification
- Predictive LTV based on first purchase
- Product growth trajectory segmentation

#### Business Intelligence Dashboards (5 queries)
- Comprehensive KPI dashboard (single query, multiple metrics)
- Customer health score (multi-factor composite metric)
- Rating-sales correlation analysis
- Time-to-repeat-purchase metrics
- Cross-sell opportunity identification

**Business Value:** Data-driven product recommendations and executive dashboards

---

### **5️⃣ The Office Special (20 queries)** 🎬
**Skills:** Creative problem-solving, Storytelling with data

A fun twist analyzing Dunder Mifflin employees' shopping behavior:

- **Michael Scott:** How many "World's Best Boss" mugs? (Spoiler: 28 mugs!)
- **Dwight Schrute:** Verified 225 beet seed packages purchased
- **Jim Halpert:** Tracking prank supply orders (Stapler in Jello Kits)
- **Stanley Hudson:** Pretzel-related purchase analysis
- **Kevin Malone:** Who left the 1-star chili pot review?

Plus: Scranton regional analysis, Dunder Mifflin product performance, and character lifetime value rankings.

**Business Value:** Demonstrates ability to make data analysis engaging and memorable

---

## 🔍 Key Technical Highlights

### Advanced SQL Techniques Used:
```sql
✅ Window Functions (ROW_NUMBER, RANK, LEAD, LAG, Running totals)
✅ Common Table Expressions (CTEs) for complex multi-step queries
✅ Subqueries (correlated and non-correlated)
✅ Self-joins for cohort and time-series analysis
✅ CASE statements for dynamic segmentation
✅ Date arithmetic (DATEDIFF, DATE_ADD, DAYOFWEEK)
✅ Aggregate functions with GROUP BY and HAVING
✅ Multi-table JOINs (INNER, LEFT, RIGHT)
✅ Set operations (UNION, INTERSECT, EXCEPT concepts)
✅ Percentile calculations for Pareto analysis
```

### Business Metrics Calculated:
```
📊 Revenue Metrics: Total revenue, AOV, LTV, running totals
📊 Customer Metrics: Churn rate, retention rate, RFM scores, health scores
📊 Product Metrics: Turnover rate, profit margin, stock-to-sales ratio
📊 Operational Metrics: Fulfillment time, cancellation rate, delivery SLA
📊 Growth Metrics: YoY growth, MoM trends, cohort contribution
```

---

## 🚀 Sample Queries

### Example 1: Customer Lifetime Value (LTV)
```sql
-- 2.2.3: Calculate total revenue generated by each customer
-- Critical metric for understanding customer value and targeting
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.customer_segment,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM((oi.quantity * oi.unit_price) * (1 - oi.discount_percentage/100)) AS lifetime_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status != 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, c.customer_segment
ORDER BY lifetime_value DESC;
```

### Example 2: RFM Analysis
```sql
-- 3.1.1: Segment customers by Recency, Frequency, and Monetary value
-- Foundation for targeted marketing campaigns
WITH rfm_calc AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        DATEDIFF(CURDATE(), MAX(o.order_date)) AS recency_days,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM((oi.quantity * oi.unit_price) * (1 - oi.discount_percentage/100)) AS monetary
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.first_name, c.last_name
),
rfm_scores AS (
    SELECT 
        *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary) AS monetary_score
    FROM rfm_calc
)
SELECT 
    *,
    CONCAT(recency_score, frequency_score, monetary_score) AS rfm_segment,
    CASE 
        WHEN recency_score >= 4 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'Champions'
        WHEN recency_score >= 3 AND frequency_score >= 3 THEN 'Loyal Customers'
        WHEN recency_score >= 4 AND frequency_score <= 2 THEN 'New Customers'
        WHEN recency_score <= 2 AND frequency_score >= 3 THEN 'At Risk'
        WHEN recency_score <= 2 AND frequency_score <= 2 THEN 'Lost'
        ELSE 'Potential'
    END AS customer_segment
FROM rfm_scores
ORDER BY monetary DESC;
```

### Example 3: The Office Special - Dwight's Beet Empire
```sql
-- 5.3.1: Verify Dwight Schrute's massive beet seed purchases
-- Demonstrates JOIN proficiency with a fun twist
SELECT 
    c.first_name,
    c.last_name,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_ordered,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    COUNT(DISTINCT o.order_id) AS number_of_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.last_name = 'Schrute' 
  AND p.product_name LIKE '%Beet%'
GROUP BY c.first_name, c.last_name, p.product_name;

-- Result: Dwight ordered 225 beet seed packages across 9 orders!
-- Total spent on beets: $3,372.75
-- That's a lot of Schrute Farms beets! 🥬
```

---

## 📈 Business Impact & Insights

### Key Findings from the Analysis:

**Customer Insights:**
- VIP customers (25% of base) generate 60% of total revenue → Focus retention programs here
- 35% churn rate after 90 days → Implement re-engagement campaigns
- Scranton customers have 18% higher AOV than national average

**Product Performance:**
- Top 3 categories (Laptops, Smartphones, Tablets) = 75% of revenue
- 12 products have zero orders → Clearance candidates
- Products with 4.5+ ratings have 40% higher repeat purchase rate

**Operational Efficiency:**
- Average delivery time: 4.8 days (within 5-day SLA)
- 8% cancellation rate → Investigate causes
- Pending orders beyond 5 days: 3 orders requiring attention

**Growth Opportunities:**
- 2022 cohort has 68% retention vs 42% for 2023 cohort → Improve onboarding
- Cross-sell opportunity: 85% of MacBook buyers also purchase accessories
- Seasonal spike in Q4 (holiday shopping) → Plan inventory accordingly

---

## 🛠️ Technologies Used

- **Database:** MySQL 8.0
- **Query Tool:** MySQL Workbench / CLI
- **Version Control:** Git & GitHub
- **Documentation:** Markdown

---

## 📂 Repository Structure

```
sql-portfolio/
├── README.md                          # This file
├── SQL_PORTFOLIO.sql                  # Complete query collection (1,194 lines)
├── ecommerce_database.sql             # Database schema & sample data
├── insights/
│   ├── customer_analysis.md           # Customer behavior insights
│   ├── product_performance.md         # Product & inventory insights
│   └── office_special_findings.md     # The Office analysis results
├── ratings vs sales.png             
├── revenue barchart.png           
└── top10products.png           
```

---

## 🎓 Learning Outcomes

Through this project, I demonstrated:

1. **Technical Proficiency:** Advanced SQL techniques including window functions, CTEs, and complex JOINs
2. **Business Acumen:** Understanding of key metrics (LTV, churn, AOV, retention)
3. **Analytical Thinking:** Breaking down complex business questions into SQL queries
4. **Communication:** Clear documentation and business-oriented query comments
5. **Creativity:** Making data analysis engaging through storytelling (The Office theme)

---

## 🔗 Connect With Me

**Ibrahim** | Data Analyst

- 📧 Email: [hema.kh10@gmail.com]
- 💼 LinkedIn: [linkedin.com/in/ibrahim-khalil-ai]
- 🐱 GitHub: [github.com/hemagamer]


---

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🙏 Acknowledgments

- Database design inspired by real e-commerce analytics challenges
- *The Office* characters used for educational and entertainment purposes
- Thanks to the SQL community for best practices and optimization techniques

---

**⭐ If you found this portfolio helpful, please consider giving it a star!**

---

*"I'm not superstitious, but I am a little stitious about data quality."* - Michael Scott (probably)

---

## 📊 Quick Stats

```
Total Queries: 90+
Lines of SQL: 1,194
Database Tables: 5
Total Records: 500+
Time Period: 2022-2024
Query Complexity: Beginner → Expert
Fun Factor: Over 9000 (Dundies awarded)
```


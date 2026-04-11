# 🚀 Tech Shop E-Commerce Analytics Portfolio

<div align="center">

![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-success?style=for-the-badge)

### 📊 From Database to Dashboard: A Complete Data Analytics Pipeline

*Demonstrating end-to-end data analysis from SQL queries to executive-ready business intelligence*

[View SQL Queries](#-sql-analytics-layer) • [View Excel Dashboard](#-excel-bi-layer) • [Key Insights](#-business-insights) • [Contact](#-contact)

</div>

---

## 🎯 What Makes This Portfolio Unique?

This isn't just another SQL project or Excel dashboard — **it's a complete data analytics workflow** that mirrors real-world business intelligence operations:

```mermaid
graph LR
    A[MySQL Database] -->|90+ SQL Queries| B[Data Extraction]
    B -->|MEGA Query| C[CSV Export]
    C -->|Excel Import| D[Data Modeling]
    D -->|43 Tasks| E[Interactive Dashboard]
    E -->|Insights| F[Business Decisions]
```

### 🔥 What You'll Find Here

- **📊 SQL Analytics Layer**: 90+ queries across 6 difficulty tiers
- **📈 Excel BI Layer**: Interactive dashboard with 43 progressive analytics tasks
- **🎬 Office Easter Egg**: Dunder Mifflin characters as customers (because why not?)
- **🔗 Complete Pipeline**: From raw database to executive presentation
- **💡 Real Insights**: Actionable business intelligence, not just pretty charts

---

## 📂 Repository Structure

```
sql-portfolio/
├── 📘 README.md                          # You are here (Executive Summary)
├── 📜 SQL_PORTFOLIO.sql                  # Complete SQL query collection (1,194 lines)
├── 🗄️ ecommerce_database.sql             # Database schema & sample data
│
├── 📊 insights/                          # SQL Analysis Documentation
│   ├── customer_analysis.md           
│   ├── product_performance.md         
│   └── office_special_findings.md     
│
├── 📸 Visualizations
│   ├── ratings_vs_sales.png               
│   ├── revenue_barchart.png               
│   └── top10products.png                  
│
└── 📈 excel_bi_dashboard/                # 🆕 The Business Intelligence Layer
    ├── TECH_SHOP_V1_Cleaned47.xlsx    # Interactive Excel Dashboard
    ├── README.md                      # Excel-specific documentation
    ├── mega_query.sql                 # The bridge: SQL → Excel export query
    └── dashboard_screenshots/         # Visual previews
```

---

## 💼 Business Context

### The Challenge
A fictional e-commerce company "Tech Shop" needs comprehensive analytics to:
- Understand customer purchasing behavior
- Optimize inventory management
- Identify revenue drivers
- Segment customers for targeted marketing
- Track business KPIs in real-time

### The Solution
A **two-layer analytics system**:

1. **SQL Layer** (Data Foundation)
   - Database design and optimization
   - Complex queries for deep analysis
   - Ad-hoc reporting capabilities

2. **Excel Layer** (Business Intelligence)
   - Executive dashboard for stakeholders
   - Interactive filters and slicers
   - Automated insights and alerts
   - Self-service analytics

---

## 📊 The Numbers

<div align="center">

| Metric | SQL Layer | Excel Layer | Combined |
|--------|-----------|-------------|----------|
| **Lines of Code** | 1,194 SQL | 500+ formulas | 1,694+ |
| **Data Points** | 17,638 transactions | 37 columns | $9.9M analyzed |
| **Customers** | 311 unique | 4 segments | 100% coverage |
| **Products** | 150+ items | 8 categories | Full catalog |
| **Time Period** | 2024-2026 | 36 months | 3,201 orders |
| **Visualizations** | 3 charts | 12+ charts | 15+ total |
| **Analytics Depth** | 6 tiers | 6 tiers | 90+ queries + 43 tasks |

</div>

---

## 🔍 SQL Analytics Layer

### Query Categories (90+ Queries)

#### ⭐ Tier 1: Fundamentals (15 queries)
Basic SELECT statements, filtering, sorting, and simple aggregations
- Customer & product lookups
- Order history retrieval
- Basic revenue calculations

#### ⭐⭐ Tier 2: Intermediate (18 queries)
JOINs, GROUP BY, aggregate functions, and basic analytics
- Multi-table joins
- Sales by category/segment
- Time-based analysis

#### ⭐⭐⭐ Tier 3: Advanced (20 queries)
Subqueries, CTEs, window functions, and complex aggregations
- Customer lifetime value
- Product performance rankings
- Revenue trends and patterns

#### ⭐⭐⭐⭐ Tier 4: Expert (15 queries)
Advanced window functions, complex CTEs, and business logic
- RFM customer segmentation
- Cohort retention analysis
- Inventory optimization

#### ⭐⭐⭐⭐⭐ Tier 5: Master (12 queries)
Complex analytical queries and business intelligence
- Year-over-year growth
- Customer churn prediction
- ABC inventory classification

#### 🎬 Tier 6: Office Special (10+ queries)
Fun analysis of Dunder Mifflin character purchases
- Character spending patterns
- Scranton branch vs. national comparison
- Product preferences by character

### Sample Query: RFM Segmentation
```sql
WITH customer_rfm AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        DATEDIFF(CURDATE(), MAX(o.order_date)) AS recency_days,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percentage/100)) AS monetary
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_id, customer_name
),
rfm_scores AS (
    SELECT 
        *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency) AS f_score,
        NTILE(5) OVER (ORDER BY monetary) AS m_score
    FROM customer_rfm
)
SELECT 
    customer_name,
    recency_days,
    frequency,
    ROUND(monetary, 2) AS lifetime_value,
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champion'
        WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal'
        WHEN r_score <= 2 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost'
        ELSE 'Regular'
    END AS customer_segment
FROM rfm_scores
ORDER BY monetary DESC;
```

---

## 📈 Excel BI Layer

### The MEGA Query: Bridging SQL to Excel

This single query exports **37 columns** of analysis-ready data from the MySQL database to Excel:

<details>
<summary><b>📝 Click to view the complete MEGA query (93 lines)</b></summary>

```sql
SELECT 
    -- ============================================
    -- ORDER INFORMATION
    -- ============================================
    o.order_id,
    o.order_date,
    DATE_FORMAT(o.order_date, '%Y-%m-%d') AS order_date_formatted,
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    MONTHNAME(o.order_date) AS month_name,
    DAYNAME(o.order_date) AS day_name,
    DAYOFWEEK(o.order_date) AS day_of_week,
    QUARTER(o.order_date) AS quarter,
    o.order_status,
    o.payment_method,
    
    -- ============================================
    -- CUSTOMER INFORMATION
    -- ============================================
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.city,
    c.country,
    c.customer_segment,
    c.registration_date,
    DATEDIFF(o.order_date, c.registration_date) AS customer_age_at_order,
    
    -- ============================================
    -- PRODUCT INFORMATION
    -- ============================================
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    p.price AS list_price,
    p.cost,
    p.stock_quantity,
    
    -- ============================================
    -- ORDER ITEM DETAILS
    -- ============================================
    oi.order_item_id,
    oi.quantity,
    oi.unit_price,
    oi.discount_percentage,
    
    -- ============================================
    -- CALCULATED FINANCIAL METRICS
    -- ============================================
    (oi.quantity * oi.unit_price) AS gross_revenue,
    (oi.quantity * oi.unit_price * oi.discount_percentage / 100) AS discount_amount,
    (oi.quantity * oi.unit_price * (1 - oi.discount_percentage / 100)) AS net_revenue,
    (oi.quantity * p.cost) AS total_cost,
    ((oi.unit_price - p.cost) * oi.quantity * (1 - oi.discount_percentage / 100)) AS profit,
    CASE 
        WHEN oi.unit_price > 0 
        THEN ((oi.unit_price - p.cost) / oi.unit_price * 100)
        ELSE 0 
    END AS profit_margin_percent,
    
    -- ============================================
    -- OFFICE SPECIAL FLAGS
    -- ============================================
    CASE 
        WHEN p.product_name LIKE '%Office%' 
          OR p.product_name LIKE '%Dunder%'
          OR p.product_name LIKE '%Boss Mug%'
          OR p.product_name LIKE '%Beet%'
          OR p.product_name LIKE '%Dundies%'
          OR p.product_name LIKE '%Pretzel%'
          OR p.product_name LIKE '%Schrute%'
          OR p.product_name LIKE '%Stapler%'
          OR p.product_name LIKE '%Threat Level%'
        THEN 'Yes'
        ELSE 'No'
    END AS is_office_product,
    
    CASE 
        WHEN c.city = 'Scranton' THEN 'Yes'
        ELSE 'No'
    END AS is_scranton

FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id

WHERE o.order_status = 'Delivered'

ORDER BY o.order_date DESC, o.order_id, oi.order_item_id;
```

**What this query does:**
- ✅ Joins 4 tables (orders, customers, order_items, products)
- ✅ Calculates 6 financial metrics (revenue, profit, margins)
- ✅ Extracts 10 date/time dimensions for trend analysis
- ✅ Adds 2 special flags for Office character analysis
- ✅ Delivers 37 columns of analysis-ready data
- ✅ Exports cleanly to CSV → Excel pipeline

</details>

### Dashboard Features (43 Tasks Across 6 Tiers)

#### 📊 Tab 1: Executive Dashboard
- 5 large KPI cards with YoY comparisons
- Revenue trend line chart (2022-2024)
- Category performance column chart
- Customer segment donut chart
- Top 10 products bar chart
- Interactive filters (Year, Segment, Category)
- Auto-generated business insights

#### 📈 Tab 2: Sales Analysis
- Monthly sales trends table
- Category performance breakdown
- Payment method analysis
- Sales heatmap (Category × Month)
- Top 10 cities ranking
- Interactive pivot tables with slicers

#### 👥 Tab 3: Customer Analytics
- **RFM Segmentation** (Champion, Loyal, At Risk, Lost)
- Cohort retention analysis
- At-risk customer alerts
- Customer lifetime value distribution
- Segment performance comparison

#### 📦 Tab 4: Product Performance
- Inventory alert system (Critical/Low/OK)
- Stock days remaining calculator
- Profit margin analysis by product
- ABC inventory classification
- Price vs. Margin scatter plot

#### 🎬 Tab 5: Office Special
- Dunder Mifflin character leaderboard
- Product purchase patterns by character
- Scranton branch vs. National comparison
- Boss Mug sales to Michael Scott
- Dwight's beet product obsession tracker

#### 🗄️ Tab 6: Data
- Raw data table (37 columns, 3,201 rows)
- Formatted and validated
- Source for all analysis

### Excel Skills Demonstrated

<table>
<tr>
<td width="50%">

**Advanced Formulas**
- XLOOKUP
- SUMIFS/COUNTIFS/AVERAGEIFS
- Dynamic Arrays (FILTER, SORT, UNIQUE, TAKE)
- Complex IF/AND/OR logic
- TEXT/DATE functions
- IFERROR/IFNA

</td>
<td width="50%">

**Data Visualization**
- 12+ professional charts
- Conditional formatting
- Color scales & data bars
- Icon sets & traffic lights
- Custom color schemes
- Dashboard UX design

</td>
</tr>
<tr>
<td>

**Pivot Tables**
- 6 interactive pivots
- Calculated fields
- % of Total analysis
- Date grouping
- Hierarchical drill-down
- Slicer connections

</td>
<td>

**Business Intelligence**
- RFM customer segmentation
- Cohort retention tracking
- ABC inventory classification
- Pareto analysis (80/20 rule)
- KPI monitoring
- Automated alerts

</td>
</tr>
</table>

---

## 💡 Business Insights

### 🎯 Strategic Findings

<div align="center">

| Category | Key Finding | Business Impact |
|----------|-------------|-----------------|
| **💰 Revenue** | Cameras drive 26% of revenue ($2.54M) | Focus marketing on high-value categories |
| **👥 Customers** | VIP segment (11%) generates 16% of revenue | Prioritize VIP retention programs |
| **📦 Inventory** | 6 critical products at risk (<30 days stock) | Immediate reorder needed ($228K at stake) |
| **🎯 Segments** | At-risk customers represent $450K in LTV | Launch win-back campaign urgently |
| **🏪 Geography** | Scranton AOV 31% below national average | Investigate local market dynamics |
| **📊 Trends** | December revenue 3.2× monthly average | Optimize inventory for Q4 surge |

</div>

### 📈 Specific Recommendations

1. **Customer Retention** 
   - 47 "At Risk" customers identified (>90 days inactive)
   - Implement automated email campaign
   - Estimated recovery: $120K-180K

2. **Inventory Optimization**
   - Reorder 6 critical products immediately
   - Implement automated stock alerts
   - Prevent $228K in lost sales

3. **Marketing Focus**
   - Double down on Camera category (highest margin: 34%)
   - Target VIP customers with exclusive offers
   - Expand enterprise segment (fastest growing)

4. **Scranton Branch**
   - Investigate 31% AOV gap vs. national
   - Review product mix and pricing
   - Potential opportunity: $125K annual uplift

---

## 🛠️ Technical Stack

<div align="center">

| Technology | Purpose | Proficiency |
|------------|---------|-------------|
| **MySQL** | Database design, complex queries, window functions | ⭐⭐⭐⭐⭐ |
| **Excel** | Pivot tables, advanced formulas, dashboard design | ⭐⭐⭐⭐⭐ |
| **SQL** | CTEs, subqueries, joins, analytical functions | ⭐⭐⭐⭐⭐ |
| **Data Modeling** | Schema design, normalization, relationships | ⭐⭐⭐⭐ |
| **BI Concepts** | KPIs, RFM, cohorts, ABC analysis, Pareto | ⭐⭐⭐⭐⭐ |

</div>

---

## 🚀 Getting Started

### Prerequisites
```bash
# For SQL Layer
- MySQL 8.0+
- MySQL Workbench (or any SQL client)

# For Excel Layer
- Microsoft Excel 2019+ (Microsoft 365 recommended)
- 10MB disk space
```

### Quick Start

#### 1️⃣ Set Up the Database

```sql
-- Import the database schema
SOURCE ecommerce_database.sql;

-- Verify setup
SELECT COUNT(*) FROM customers;  -- Should return 311
SELECT COUNT(*) FROM orders;     -- Should return 3,201
```

#### 2️⃣ Run SQL Queries

```sql
-- Open SQL_PORTFOLIO.sql in MySQL Workbench
-- Execute queries by tier (Tier 1 → Tier 6)
-- Each query is documented with purpose and expected output
```

#### 3️⃣ Export Data for Excel

```sql
-- Run the MEGA query (found in excel_bi_dashboard/mega_query.sql)
-- Export results as CSV
-- File → Export → tech_shop_data.csv
```

#### 4️⃣ Open Excel Dashboard

```bash
# Navigate to excel_bi_dashboard/
# Open: TECH_SHOP_V1_Cleaned47.xlsx
# Start with Tab 1 (Executive Dashboard)
# Use filters and slicers to explore
```

---

## 📸 Screenshots

### SQL Query Results
![Revenue Analysis](revenue_barchart.png)
*Top 10 products by revenue - SQL query visualization*

![Ratings vs Sales](ratings_vs_sales.png)
*Product ratings correlation with sales performance*

### Excel Dashboard Preview
> **Coming Soon**: Executive Dashboard screenshots showing:
> - KPI cards with YoY comparisons
> - Interactive filters and slicers
> - Revenue trend analysis
> - RFM customer segmentation
> - Inventory alert system

---

## 🎓 What I Learned

### Technical Skills Developed

**SQL Mastery**
- Complex multi-table JOINs
- Window functions for rankings and running totals
- CTEs for query organization
- Performance optimization techniques
- Date/time manipulation
- String matching with LIKE and REGEXP

**Excel Advanced Techniques**
- Dynamic arrays for self-updating reports
- XLOOKUP for flexible data retrieval
- Pivot table calculated fields
- Conditional formatting for visual insights
- Dashboard design principles
- Formula optimization for large datasets

**Business Intelligence Concepts**
- RFM customer segmentation methodology
- Cohort analysis for retention tracking
- ABC inventory classification
- Pareto principle (80/20 rule) application
- KPI selection and monitoring
- Data storytelling techniques

### Analytical Thinking

- Translating business questions into SQL queries
- Choosing appropriate visualizations for different data types
- Identifying actionable insights from raw data
- Building scalable, maintainable analytics solutions
- Balancing detail with executive-level clarity

---

## 🎯 Project Timeline

| Phase | Duration | Deliverables |
|-------|----------|--------------|
| **Planning** | 2 days | Database schema, project scope |
| **SQL Development** | 1 week | 90+ queries across 6 tiers |
| **Data Export** | 1 day | MEGA query, CSV generation |
| **Excel Build** | 2 weeks | 43 tasks, 6 tabs, complete dashboard |
| **Documentation** | 3 days | README files, code comments |
| **Testing & QA** | 2 days | Formula validation, error handling |

**Total:** ~4 weeks (part-time)

---

## 📊 Project Metrics

```
📝 SQL Queries Written: 90+
📜 Lines of SQL Code: 1,194
📈 Excel Formulas: 500+
📊 Charts Created: 15+
🔢 Pivot Tables: 6
📋 Named Ranges: 8
🎨 Conditional Format Rules: 15+
⚡ Dynamic Arrays: 20+
⏱️ Total Hours Invested: ~120
```

---

## 🤝 Contributing

This is a portfolio project, but I welcome:

- 💡 Suggestions for additional analyses
- 🐛 Bug reports or data quality issues
- 🔧 Query optimization ideas
- 📊 Additional visualization concepts
- 💬 General feedback

**To contribute:**
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## ⚠️ Data Disclaimer

**Important Notice:**

All data in this project is **100% synthetically generated** for educational and portfolio demonstration purposes. This dataset does not represent:

- ❌ Any real business or company
- ❌ Actual customer information
- ❌ Real-world transactions
- ❌ Genuine financial figures

The "Office" character names (Michael Scott, Dwight Schrute, Jim Halpert, etc.) are used for entertainment and demonstration purposes under fair use for educational projects. All trademarks are property of NBC Universal.

---

## 📧 Contact

<div align="center">

### **Ibrahim Khalil**
*Data Analyst | BSc Computer Science (Artificial Intelligence)*

[![Email](https://img.shields.io/badge/Email-hema.kh10@gmail.com-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:hema.kh10@gmail.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-ibrahim--khalil--ai-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/ibrahim-khalil-ai)
[![GitHub](https://img.shields.io/badge/GitHub-hemagamer-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/hemagamer)

</div>

### Open to Opportunities

I'm actively seeking positions in:
- 📊 Data Analyst roles
- 📈 Business Intelligence positions
- 🔍 Analytics consulting
- 💼 Freelance data projects

**What I bring:**
- Strong SQL and Excel skills (demonstrated here!)
- Python for data analysis
- Machine learning fundamentals (BSc in AI)
- Business acumen and communication skills
- Passion for turning data into actionable insights

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Disclaimer:** Microsoft Excel, MySQL, and all related trademarks are property of their respective owners.

---

## ⭐ Show Your Support

If this portfolio project helped you learn SQL/Excel analytics or inspired your own work:

<div align="center">

[![Star this repo](https://img.shields.io/github/stars/hemagamer/sql-portfolio?style=social)](https://github.com/hemagamer/sql-portfolio)
[![Fork this repo](https://img.shields.io/github/forks/hemagamer/sql-portfolio?style=social)](https://github.com/hemagamer/sql-portfolio/fork)

**⭐ Star this repository**  
**🔀 Fork it to build your own version**  
**📢 Share with others learning data analytics**  
**💬 Leave feedback in Issues**

</div>

---

## 🔗 Related Projects

### Coming Soon
- 🐍 **Python Data Analysis**: Automated reporting pipeline
- 📊 **Power BI Dashboard**: Interactive visual analytics
- 🤖 **ML Customer Churn Model**: Predictive analytics

---

<div align="center">

### 💭 Final Thoughts

> *"Data is the new oil, but analytics is the combustion engine that makes it useful."*

This project represents more than just technical skills—it demonstrates my ability to:
- Think like a business analyst
- Communicate with data
- Build scalable solutions
- Turn complexity into clarity

**Thank you for exploring my portfolio!**

---

**Built with** 📊 SQL • 📈 Excel • 💪 Determination • ☕ Coffee

*Transforming data into decisions, one query at a time.*

---

![Visitor Count](https://visitor-badge.laobi.icu/badge?page_id=hemagamer.sql-portfolio)
![Last Commit](https://img.shields.io/github/last-commit/hemagamer/sql-portfolio)
![Repo Size](https://img.shields.io/github/repo-size/hemagamer/sql-portfolio)

**Last Updated:** April 10, 2026  
**Version:** 2.0 (SQL + Excel Complete)  
**Status:** ✅ Production Ready

</div>

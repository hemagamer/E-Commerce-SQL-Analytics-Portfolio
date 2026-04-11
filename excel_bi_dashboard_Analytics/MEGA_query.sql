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
    -- c.state,
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
    -- p.rating,
    
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


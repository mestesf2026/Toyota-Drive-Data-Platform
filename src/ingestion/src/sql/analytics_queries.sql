-- ============================================================
-- ToyotaDrive Analytics Queries
-- Business Intelligence Layer
-- ============================================================


-- ============================================================
-- 1. SALES KPI SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_vehicles_sold,
    ROUND(SUM(selling_price)::numeric, 2) AS total_sales_revenue,
    ROUND(AVG(selling_price)::numeric, 2) AS average_vehicle_price
FROM fact_sales;


-- ============================================================
-- 2. MONTHLY SALES PERFORMANCE
-- ============================================================

SELECT
    d.year,
    d.month,
    d.month_name,
    COUNT(f.sales_key) AS vehicles_sold,
    ROUND(SUM(f.selling_price)::numeric, 2) AS revenue,
    ROUND(AVG(f.selling_price)::numeric, 2) AS average_price
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;


-- ============================================================
-- 3. SALES BY VEHICLE MAKE
-- ============================================================

SELECT
    v.make,
    COUNT(f.sales_key) AS vehicles_sold,
    ROUND(SUM(f.selling_price)::numeric, 2) AS revenue,
    ROUND(AVG(f.selling_price)::numeric, 2) AS average_price
FROM fact_sales f
LEFT JOIN dim_vehicle v
    ON f.vehicle_key = v.vehicle_key
GROUP BY
    v.make
ORDER BY
    revenue DESC;


-- ============================================================
-- 4. SALES BY VEHICLE MODEL
-- ============================================================

SELECT
    v.make,
    v.model,
    COUNT(f.sales_key) AS vehicles_sold,
    ROUND(SUM(f.selling_price)::numeric, 2) AS revenue
FROM fact_sales f
LEFT JOIN dim_vehicle v
    ON f.vehicle_key = v.vehicle_key
GROUP BY
    v.make,
    v.model
ORDER BY
    revenue DESC;


-- ============================================================
-- 5. REPAIR KPIs
-- ============================================================

SELECT
    COUNT(*) AS total_repairs,
    ROUND(SUM(repair_cost)::numeric, 2) AS total_repair_revenue,
    ROUND(AVG(repair_cost)::numeric, 2) AS average_repair_cost
FROM fact_repairs;


-- ============================================================
-- 6. REPAIR PERFORMANCE BY MONTH
-- ============================================================

SELECT
    EXTRACT(YEAR FROM repair_date) AS year,
    EXTRACT(MONTH FROM repair_date) AS month,
    COUNT(*) AS repairs,
    ROUND(SUM(repair_cost)::numeric, 2) AS repair_revenue,
    ROUND(AVG(repair_cost)::numeric, 2) AS average_repair_cost
FROM fact_repairs
GROUP BY
    EXTRACT(YEAR FROM repair_date),
    EXTRACT(MONTH FROM repair_date)
ORDER BY
    year,
    month;


-- ============================================================
-- 7. ECONOMIC INDICATOR
-- ============================================================

SELECT
    EXTRACT(YEAR FROM economic_date) AS year,
    EXTRACT(MONTH FROM economic_date) AS month,
    unemployment_rate
FROM dim_economic
ORDER BY
    year,
    month;


-- ============================================================
-- 8. SALES + ECONOMIC INDICATOR
-- ============================================================

SELECT
    d.year,
    d.month,
    d.month_name,
    COUNT(f.sales_key) AS vehicles_sold,
    ROUND(SUM(f.selling_price)::numeric, 2) AS sales_revenue,
    e.unemployment_rate
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
LEFT JOIN dim_economic e
    ON d.year = EXTRACT(YEAR FROM e.economic_date)
    AND d.month = EXTRACT(MONTH FROM e.economic_date)
GROUP BY
    d.year,
    d.month,
    d.month_name,
    e.unemployment_rate
ORDER BY
    d.year,
    d.month;


-- ============================================================
-- 9. MANAGEMENT KPI SUMMARY
-- ============================================================

SELECT
    (SELECT COUNT(*) FROM fact_sales)
        AS vehicles_sold,

    (SELECT ROUND(SUM(selling_price)::numeric, 2)
     FROM fact_sales)
        AS sales_revenue,

    (SELECT ROUND(AVG(selling_price)::numeric, 2)
     FROM fact_sales)
        AS average_vehicle_price,

    (SELECT COUNT(*) FROM fact_repairs)
        AS total_repairs,

    (SELECT ROUND(SUM(repair_cost)::numeric, 2)
     FROM fact_repairs)
        AS repair_revenue,

    (SELECT ROUND(AVG(repair_cost)::numeric, 2)
     FROM fact_repairs)
        AS average_repair_cost;

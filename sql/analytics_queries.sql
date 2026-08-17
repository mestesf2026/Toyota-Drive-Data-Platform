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
    ROUND(AVG(selling_price)::numeric, 2) AS average_vehicle_price,
    MIN(selling_price) AS minimum_selling_price,
    MAX(selling_price) AS maximum_selling_price,
    ROUND(AVG(odometer)::numeric, 0) AS average_mileage
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
    COALESCE(NULLIF(TRIM(v.make), ''), 'Unknown') AS make,
    COUNT(f.sales_key) AS vehicles_sold,
    ROUND(SUM(f.selling_price)::numeric, 2) AS revenue,
    ROUND(AVG(f.selling_price)::numeric, 2) AS average_price
FROM fact_sales f
LEFT JOIN dim_vehicle v
    ON f.vehicle_key = v.vehicle_key
GROUP BY
    COALESCE(NULLIF(TRIM(v.make), ''), 'Unknown')
ORDER BY
    revenue DESC;


-- ============================================================
-- 4. TOP VEHICLE MODELS
-- ============================================================

SELECT
    CASE
        WHEN NULLIF(TRIM(v.make), '') IS NULL
         AND NULLIF(TRIM(v.model), '') IS NULL
            THEN 'Unknown / Unspecified'
        WHEN NULLIF(TRIM(v.make), '') IS NULL
            THEN 'Unknown ' || TRIM(v.model)
        WHEN NULLIF(TRIM(v.model), '') IS NULL
            THEN TRIM(v.make) || ' Unknown'
        ELSE TRIM(v.make) || ' ' || TRIM(v.model)
    END AS vehicle,
    COUNT(f.sales_key) AS vehicles_sold,
    ROUND(SUM(f.selling_price)::numeric, 2) AS revenue,
    ROUND(AVG(f.selling_price)::numeric, 2) AS average_price
FROM fact_sales f
LEFT JOIN dim_vehicle v
    ON f.vehicle_key = v.vehicle_key
GROUP BY
    CASE
        WHEN NULLIF(TRIM(v.make), '') IS NULL
         AND NULLIF(TRIM(v.model), '') IS NULL
            THEN 'Unknown / Unspecified'
        WHEN NULLIF(TRIM(v.make), '') IS NULL
            THEN 'Unknown ' || TRIM(v.model)
        WHEN NULLIF(TRIM(v.model), '') IS NULL
            THEN TRIM(v.make) || ' Unknown'
        ELSE TRIM(v.make) || ' ' || TRIM(v.model)
    END
ORDER BY
    revenue DESC
LIMIT 15;


-- ============================================================
-- 5. PRICE RANGE ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN selling_price < 5000 THEN 'Under $5K'
        WHEN selling_price < 10000 THEN '$5K-$10K'
        WHEN selling_price < 20000 THEN '$10K-$20K'
        WHEN selling_price < 30000 THEN '$20K-$30K'
        ELSE '$30K+'
    END AS price_range,
    COUNT(*) AS sales,
    ROUND(SUM(selling_price)::numeric, 2) AS revenue,
    ROUND(AVG(selling_price)::numeric, 2) AS average_price
FROM fact_sales
GROUP BY
    CASE
        WHEN selling_price < 5000 THEN 'Under $5K'
        WHEN selling_price < 10000 THEN '$5K-$10K'
        WHEN selling_price < 20000 THEN '$10K-$20K'
        WHEN selling_price < 30000 THEN '$20K-$30K'
        ELSE '$30K+'
    END
ORDER BY
    MIN(selling_price);


-- ============================================================
-- 6. MILEAGE ANALYSIS
-- ============================================================

SELECT
    CASE
        WHEN odometer < 30000 THEN 'Under 30K'
        WHEN odometer < 60000 THEN '30K-60K'
        WHEN odometer < 100000 THEN '60K-100K'
        ELSE '100K+'
    END AS mileage_range,
    COUNT(*) AS sales,
    ROUND(AVG(selling_price)::numeric, 2) AS average_price
FROM fact_sales
GROUP BY
    CASE
        WHEN odometer < 30000 THEN 'Under 30K'
        WHEN odometer < 60000 THEN '30K-60K'
        WHEN odometer < 100000 THEN '60K-100K'
        ELSE '100K+'
    END
ORDER BY
    MIN(odometer);


-- ============================================================
-- 7. SALES BY DEALER
-- ============================================================

SELECT
    d.dealer_id,
    d.dealer_name,
    COUNT(f.sales_key) AS sales,
    COALESCE(ROUND(SUM(f.selling_price)::numeric, 2), 0) AS revenue
FROM dim_dealer d
LEFT JOIN fact_sales f
    ON d.dealer_key = f.dealer_key
GROUP BY
    d.dealer_id,
    d.dealer_name
ORDER BY
    sales DESC;


-- ============================================================
-- 8. VEHICLE DATA QUALITY
-- ============================================================

SELECT
    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(v.make), '') IS NULL
           OR NULLIF(TRIM(v.model), '') IS NULL
    ) AS incomplete_vehicle_sales,

    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(v.make), '') IS NULL
          AND NULLIF(TRIM(v.model), '') IS NULL
    ) AS both_make_model_unknown,

    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(v.make), '') IS NULL
          AND NULLIF(TRIM(v.model), '') IS NOT NULL
    ) AS make_unknown_only,

    COUNT(*) FILTER (
        WHERE NULLIF(TRIM(v.make), '') IS NOT NULL
          AND NULLIF(TRIM(v.model), '') IS NULL
    ) AS model_unknown_only
FROM fact_sales f
JOIN dim_vehicle v
    ON f.vehicle_key = v.vehicle_key;


-- ============================================================
-- 9. SALES BY YEAR
-- ============================================================

SELECT
    d.year,
    COUNT(*) AS sales,
    ROUND(SUM(f.selling_price)::numeric, 2) AS revenue,
    ROUND(AVG(f.selling_price)::numeric, 2) AS average_price
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year
ORDER BY
    d.year;


-- ============================================================
-- 10. REPAIR KPI SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_repairs,
    ROUND(SUM(repair_cost)::numeric, 2) AS total_repair_revenue,
    ROUND(AVG(repair_cost)::numeric, 2) AS average_repair_cost
FROM fact_repairs;


-- ============================================================
-- 11. MONTHLY REPAIR PERFORMANCE
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
-- 12. ECONOMIC INDICATOR
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
-- 13. SALES + ECONOMIC INDICATOR
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
-- 14. MANAGEMENT KPI SUMMARY
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


-- ============================================================
-- 15. WAREHOUSE DATA RECONCILIATION
-- ============================================================

SELECT
    (SELECT COUNT(*) FROM fact_sales) AS total_fact_sales,

    (SELECT COUNT(*)
     FROM fact_sales f
     JOIN dim_vehicle v
       ON f.vehicle_key = v.vehicle_key) AS matched_vehicle_sales,

    (SELECT COUNT(*)
     FROM fact_sales f
     JOIN dim_date d
       ON f.date_key = d.date_key) AS matched_date_sales,

    (SELECT COUNT(*)
     FROM fact_sales f
     JOIN dim_dealer d
       ON f.dealer_key = d.dealer_key) AS matched_dealer_sales;

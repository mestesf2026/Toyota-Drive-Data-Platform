-- ============================================================
-- ToyotaDrive Analytics Queries
-- ============================================================

-- ============================================================
-- 1. Core Sales KPIs
-- ============================================================

SELECT
    COUNT(*) AS total_sales,
    SUM(selling_price) AS total_revenue,
    ROUND(AVG(selling_price), 2) AS average_selling_price,
    MIN(selling_price) AS minimum_selling_price,
    MAX(selling_price) AS maximum_selling_price,
    ROUND(AVG(odometer), 0) AS average_mileage
FROM fact_sales;


-- ============================================================
-- 2. Monthly Sales
-- ============================================================

SELECT
    d.year,
    d.month,
    d.month_name,
    COUNT(*) AS sales,
    SUM(f.selling_price) AS revenue,
    ROUND(AVG(f.selling_price), 2) AS average_price
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
-- 3. Sales by Vehicle Make
-- ============================================================

SELECT
    COALESCE(NULLIF(TRIM(v.make), ''), 'Unknown') AS make,
    COUNT(*) AS sales,
    SUM(f.selling_price) AS revenue,
    ROUND(AVG(f.selling_price), 2) AS average_price
FROM fact_sales f
JOIN dim_vehicle v
    ON f.vehicle_key = v.vehicle_key
GROUP BY
    COALESCE(NULLIF(TRIM(v.make), ''), 'Unknown')
ORDER BY
    sales DESC;


-- ============================================================
-- 4. Top Vehicle Models
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
    COUNT(*) AS sales,
    SUM(f.selling_price) AS revenue,
    ROUND(AVG(f.selling_price), 2) AS average_price
FROM fact_sales f
JOIN dim_vehicle v
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
    sales DESC
LIMIT 15;


-- ============================================================
-- 5. Price Range Analysis
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
    SUM(selling_price) AS revenue,
    ROUND(AVG(selling_price), 2) AS average_price
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
-- 6. Mileage Analysis
-- ============================================================

SELECT
    CASE
        WHEN odometer < 30000 THEN 'Under 30K'
        WHEN odometer < 60000 THEN '30K-60K'
        WHEN odometer < 100000 THEN '60K-100K'
        ELSE '100K+'
    END AS mileage_range,
    COUNT(*) AS sales,
    ROUND(AVG(selling_price), 2) AS average_price
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
-- 7. Sales by Dealer
-- ============================================================

SELECT
    d.dealer_id,
    d.dealer_name,
    COUNT(f.sales_key) AS sales,
    COALESCE(SUM(f.selling_price), 0) AS revenue
FROM dim_dealer d
LEFT JOIN fact_sales f
    ON d.dealer_key = f.dealer_key
GROUP BY
    d.dealer_id,
    d.dealer_name
ORDER BY
    sales DESC;


-- ============================================================
-- 8. Vehicle Data Quality
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
-- 9. Sales by Year
-- ============================================================

SELECT
    d.year,
    COUNT(*) AS sales,
    SUM(f.selling_price) AS revenue,
    ROUND(AVG(f.selling_price), 2) AS average_price
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year
ORDER BY d.year;


-- ============================================================
-- 10. Data Reconciliation
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

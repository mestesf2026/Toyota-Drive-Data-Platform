-- ============================================================
-- ToyotaDrive Data Warehouse Schema
-- Matches the validated Neon PostgreSQL warehouse
-- ============================================================

-- ============================================================
-- 1. Dealer Dimension
-- ============================================================

CREATE TABLE IF NOT EXISTS dim_dealer (
    dealer_key SERIAL PRIMARY KEY,
    dealer_id VARCHAR(100),
    dealer_name VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    service_department BOOLEAN
);


-- ============================================================
-- 2. Vehicle Dimension
-- ============================================================

CREATE TABLE IF NOT EXISTS dim_vehicle (
    vehicle_key SERIAL PRIMARY KEY,
    vehicle_id VARCHAR(100),
    make VARCHAR(100),
    model VARCHAR(255),
    model_year INTEGER,
    vehicle_type VARCHAR(100)
);


-- ============================================================
-- 3. Date Dimension
-- ============================================================

CREATE TABLE IF NOT EXISTS dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    day INTEGER
);


-- ============================================================
-- 4. Economic Dimension
-- ============================================================

CREATE TABLE IF NOT EXISTS dim_economic (
    economic_key SERIAL PRIMARY KEY,
    economic_date DATE,
    unemployment_rate NUMERIC(8,4)
);


-- ============================================================
-- 5. Sales Fact
-- ============================================================

CREATE TABLE IF NOT EXISTS fact_sales (
    sales_key SERIAL PRIMARY KEY,
    dealer_key INTEGER,
    vehicle_key INTEGER,
    date_key INTEGER,
    selling_price NUMERIC(12,2),
    odometer INTEGER,

    CONSTRAINT fact_sales_dealer_key_fkey
        FOREIGN KEY (dealer_key)
        REFERENCES dim_dealer(dealer_key),

    CONSTRAINT fact_sales_vehicle_key_fkey
        FOREIGN KEY (vehicle_key)
        REFERENCES dim_vehicle(vehicle_key),

    CONSTRAINT fact_sales_date_key_fkey
        FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);


-- ============================================================
-- 6. Repairs Fact
-- ============================================================

CREATE TABLE IF NOT EXISTS fact_repairs (
    repair_key SERIAL PRIMARY KEY,
    dealer_key INTEGER,
    vehicle_key INTEGER,
    repair_date DATE,
    repair_cost NUMERIC(12,2),
    mileage INTEGER,

    CONSTRAINT fact_repairs_dealer_key_fkey
        FOREIGN KEY (dealer_key)
        REFERENCES dim_dealer(dealer_key),

    CONSTRAINT fact_repairs_vehicle_key_fkey
        FOREIGN KEY (vehicle_key)
        REFERENCES dim_vehicle(vehicle_key)
);

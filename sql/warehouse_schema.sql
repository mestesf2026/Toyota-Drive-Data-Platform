-- ============================================================
-- ToyotaDrive Data Warehouse Schema
-- ============================================================

-- ============================================================
-- 1. Dealer Dimension
-- ============================================================

CREATE TABLE IF NOT EXISTS dim_dealer (
    dealer_key SERIAL PRIMARY KEY,
    dealer_id VARCHAR(100),
    dealer_name VARCHAR(255),
    dealer_city VARCHAR(100),
    dealer_state VARCHAR(100)
);


-- ============================================================
-- 2. Vehicle Dimension
-- ============================================================

CREATE TABLE IF NOT EXISTS dim_vehicle (
    vehicle_key SERIAL PRIMARY KEY,
    vin VARCHAR(50),
    make VARCHAR(100),
    model VARCHAR(100),
    body VARCHAR(100),
    transmission VARCHAR(50),
    color VARCHAR(100),
    interior VARCHAR(100)
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
    day INTEGER,
    day_name VARCHAR(20)
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
    sales_key BIGSERIAL PRIMARY KEY,
    date_key INTEGER,
    vehicle_key INTEGER,
    dealer_key INTEGER,
    selling_price NUMERIC(12,2),
    mmr NUMERIC(12,2),
    odometer NUMERIC(12,2),
    condition NUMERIC(8,2),

    CONSTRAINT fk_sales_date
        FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    CONSTRAINT fk_sales_vehicle
        FOREIGN KEY (vehicle_key)
        REFERENCES dim_vehicle(vehicle_key),

    CONSTRAINT fk_sales_dealer
        FOREIGN KEY (dealer_key)
        REFERENCES dim_dealer(dealer_key)
);


-- ============================================================
-- 6. Repairs Fact
-- ============================================================

CREATE TABLE IF NOT EXISTS fact_repairs (
    repair_key BIGSERIAL PRIMARY KEY,
    repair_date DATE,
    dealer_key INTEGER,
    vehicle_key INTEGER,
    repair_cost NUMERIC(12,2),

    CONSTRAINT fk_repairs_dealer
        FOREIGN KEY (dealer_key)
        REFERENCES dim_dealer(dealer_key),

    CONSTRAINT fk_repairs_vehicle
        FOREIGN KEY (vehicle_key)
        REFERENCES dim_vehicle(vehicle_key)
);

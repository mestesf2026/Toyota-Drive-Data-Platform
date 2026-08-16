-- ToyotaDrive Data Warehouse
-- Star Schema

CREATE TABLE IF NOT EXISTS dim_dealer (
    dealer_key SERIAL PRIMARY KEY,
    dealer_id VARCHAR(20) UNIQUE NOT NULL,
    dealer_name VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(50),
    country VARCHAR(50),
    service_department BOOLEAN
);

CREATE TABLE IF NOT EXISTS dim_vehicle (
    vehicle_key SERIAL PRIMARY KEY,
    vehicle_id VARCHAR(100),
    make VARCHAR(100),
    model VARCHAR(100),
    model_year INTEGER,
    vehicle_type VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    day INTEGER
);

CREATE TABLE IF NOT EXISTS dim_economic (
    economic_key SERIAL PRIMARY KEY,
    economic_date DATE,
    unemployment_rate DECIMAL(5,2)
);

CREATE TABLE IF NOT EXISTS fact_sales (
    sales_key SERIAL PRIMARY KEY,
    dealer_key INTEGER,
    vehicle_key INTEGER,
    date_key INTEGER,
    selling_price DECIMAL(12,2),
    odometer INTEGER,

    FOREIGN KEY (dealer_key)
        REFERENCES dim_dealer(dealer_key),

    FOREIGN KEY (vehicle_key)
        REFERENCES dim_vehicle(vehicle_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);

CREATE TABLE IF NOT EXISTS fact_repairs (
    repair_key SERIAL PRIMARY KEY,
    dealer_key INTEGER,
    vehicle_key INTEGER,
    repair_date DATE,
    repair_cost DECIMAL(12,2),
    mileage INTEGER,

    FOREIGN KEY (dealer_key)
        REFERENCES dim_dealer(dealer_key),

    FOREIGN KEY (vehicle_key)
        REFERENCES dim_vehicle(vehicle_key)
);

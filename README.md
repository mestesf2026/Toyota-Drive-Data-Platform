# ToyotaDrive Data Engineering & Analytics Platform

An end-to-end data engineering and analytics project that transforms
automotive sales data into a validated PostgreSQL data warehouse and
business intelligence dashboard.

The project demonstrates the complete workflow:

**Raw Data → Cleaning → Transformation → Warehouse → Validation → SQL Analytics → Dashboard**

---

## Project Overview

ToyotaDrive analyzes automotive sales data to provide business insights
into sales performance, vehicle demand, pricing, mileage, sales trends,
and data quality.

The platform was designed as a portfolio data engineering project with
an emphasis on:

- Data cleaning and preparation
- ETL pipeline development
- Dimensional data modeling
- PostgreSQL data warehousing
- Foreign-key validation
- Analytical SQL
- Dashboard dataset creation
- Business intelligence visualization
- Data-quality testing

---

## Business Objective

The ToyotaDrive analytics platform answers questions such as:

- How many vehicles were sold?
- What was total sales revenue?
- What was the average selling price?
- Which vehicle makes generated the most sales?
- Which vehicle models were most frequently sold?
- How did sales change over time?
- Which price ranges generated the most revenue?
- How does mileage relate to selling price?
- How complete are the vehicle descriptions?
- Are warehouse relationships and foreign keys valid?

---

# Architecture

```text
                         RAW AUTOMOTIVE DATA
                                  |
                                  v
                       +---------------------+
                       | Data Ingestion &    |
                       | Data Preparation    |
                       +---------------------+
                                  |
                                  v
                       +---------------------+
                       | Cleaning &          |
                       | Transformation      |
                       +---------------------+
                                  |
                                  v
                       +---------------------+
                       | Neon PostgreSQL     |
                       | Data Warehouse      |
                       +---------------------+
                                  |
                    +-------------+-------------+
                    |                           |
                    v                           v
             SQL Analytics              Warehouse Validation
                    |                           |
                    +-------------+-------------+
                                  |
                                  v
                       +---------------------+
                       | Dashboard Datasets  |
                       +---------------------+
                                  |
                                  v
                       +---------------------+
                       | Business Dashboard  |
                       +---------------------+

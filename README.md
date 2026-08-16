# ToyotaDrive Data Engineering & Analytics Platform

## Project Overview

ToyotaDrive is an end-to-end data engineering and analytics project designed to transform automotive sales data into a PostgreSQL data warehouse and business intelligence dashboard.

The project demonstrates a complete analytics workflow:

**Raw Data → Data Cleaning → Transformation → PostgreSQL Warehouse → SQL Analytics → Validation → Dashboard**

The platform analyzes automotive sales, vehicle information, pricing, mileage, sales trends, and data quality.

---

## Business Objective

The objective of the ToyotaDrive platform is to provide decision-makers with reliable automotive sales insights.

The analytics platform answers questions such as:

- How many vehicles were sold?
- What was the total sales revenue?
- What was the average selling price?
- Which vehicle manufacturers generated the most sales?
- Which vehicle models were most popular?
- How did sales change over time?
- Which price ranges generated the most sales?
- How does mileage affect selling price?
- How complete is the vehicle data?

---

# Architecture

```text
                    RAW AUTOMOTIVE DATA
                            |
                            v
                  +-------------------+
                  | Data Preparation  |
                  | & Cleaning        |
                  +-------------------+
                            |
                            v
                  +-------------------+
                  | Transformation    |
                  | & Data Validation |
                  +-------------------+
                            |
                            v
                  +-------------------+
                  | PostgreSQL / Neon |
                  | Data Warehouse    |
                  +-------------------+
                            |
             +--------------+--------------+
             |                             |
             v                             v
      SQL Analytics                 Validation Tests
             |                             |
             +--------------+--------------+
                            |
                            v
                  +-------------------+
                  | Dashboard Dataset |
                  +-------------------+
                            |
                            v
                  +-------------------+
                  | Analytics         |
                  | Dashboard         |
                  +-------------------+

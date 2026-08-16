# ToyotaDrive Data Engineering & Analytics Platform

## Project Overview

ToyotaDrive is a browser-based data engineering and analytics project for a fictional automotive dealership that sells, repairs, and maintains vehicles.

The project demonstrates a complete modern data pipeline:

**Data Sources → Data Lake → Data Transformation → Data Warehouse → SQL Analytics → Dashboard → Business Decisions**

The entire project can be developed using Google Colab, GitHub, Python, SQL, and a cloud PostgreSQL database.

---

## Business Problem

An automotive dealership generates data from multiple sources including:

- Vehicle sales
- Vehicle information
- Repair and maintenance services
- Dealer information
- Economic indicators

The business needs to combine these sources into one analytical platform.

Management wants to answer questions such as:

- How many vehicles are being sold?
- What is total sales revenue?
- What are the best-performing vehicle models?
- What is the average vehicle selling price?
- How many repairs are performed?
- How much repair revenue is generated?
- How does sales performance change over time?
- How can economic conditions affect business performance?

---

## Project Architecture

```text
                 DATA SOURCES
                      |
       +--------------+--------------+
       |              |              |
     Sales          Repairs       Vehicles
       |              |              |
       +--------------+--------------+
                      |
                      v
                 DATA LAKE
                      |
                      v
              PYTHON / PANDAS
                      |
                      v
             PROCESSED DATA
                      |
                      v
              NEON POSTGRESQL
                      |
                      v
              DATA WAREHOUSE
                      |
          +-----------+-----------+
          |                       |
     FACT TABLES            DIMENSIONS
          |                       |
          +-----------+-----------+
                      |
                      v
                 SQL ANALYTICS
                      |
                      v
              PLOTLY DASHBOARD
                      |
                      v
              BUSINESS DECISIONS

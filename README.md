# ToyotaDrive Motors — End-to-End Data Engineering Project

## Project Overview

ToyotaDrive Motors is a fictional automotive dealership that sells new and used cars and provides repair and maintenance services.

The goal of this project is to build an end-to-end data engineering and analytics platform that collects data from **5 different sources**, stores the raw data in a **Data Lake**, transforms the data using **Python**, loads the cleaned data into a **PostgreSQL Data Warehouse**, and provides business insights through a **BI dashboard**.

The project demonstrates how raw data can be transformed into useful information for business decision-making.

---

## Project Architecture

```text
                 5 DATA SOURCES
                      |
       +--------------+--------------+
       |       |      |      |       |
       v       v      v      v       v
     Sales  Repairs  Vehicle Dealer Economic
      Data    Data     API    Data    Data
       |       |       |       |       |
       +-------+-------+-------+-------+
                       |
                       v
                DATA LAKE - BRONZE
                  Raw CSV / JSON
                       |
                       v
              PYTHON TRANSFORMATION
                       |
                       v
                DATA LAKE - SILVER
                 Clean Parquet Data
                       |
                       v
              POSTGRESQL DATA WAREHOUSE
                       |
                       v
                   STAR SCHEMA
                       |
                       v
                   SQL ANALYTICS
                       |
                       v
                POWER BI DASHBOARD
                       |
                       v
               BUSINESS DECISIONS
